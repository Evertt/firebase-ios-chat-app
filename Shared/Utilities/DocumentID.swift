//
//  DocumentID+Hashable.swift
//  tryout
//
//  Created by Evert van Brussel on 23/07/2020.
//

import Foundation
import FirebaseFirestore
@testable import FirebaseFirestoreSwift

/// A value that is populated in Codable objects with the `DocumentReference`
/// of the current document by the Firestore.Decoder when a document is read.
///
/// If the field name used for this type conflicts with a read document field,
/// an error is thrown. For example, if a custom object has a field `firstName`
/// annotated with `@DocumentID`, and there is a property from the document
/// named `firstName` as well, an error is thrown when you try to read the
/// document.
///
/// When writing a Codable object containing an `@DocumentID` annotated field,
/// its value is ignored. This allows you to read a document from one path and
/// write it into another without adjusting the value here.
///
/// NOTE: Trying to encode/decode this type using encoders/decoders other than
/// Firestore.Encoder leads to an error.
@propertyWrapper
struct MyDocumentID: DocumentIDProtocol, Codable, Hashable {
    var value: String
    let docRef: DocumentReference?
    
    var existsInFirestore: Bool {
        docRef != nil
    }

    public init(wrappedValue value: String) {
        self.value = value
        docRef = nil
    }

    public var wrappedValue: String {
        get { value }
        set { value = newValue }
    }

    // MARK: - `DocumentIDProtocol` conformance

    init(from documentReference: DocumentReference?) {
        docRef = documentReference
        
        if let documentReference = documentReference {
            value = documentReference.documentID
        } else {
            value = UUID().description
        }
    }

    // MARK: - `Codable` implementation.

    init(from decoder: Decoder) throws {
        throw FirestoreDecodingError.decodingIsNotSupported(
            "DocumentID values can only be decoded with Firestore.Decoder"
        )
    }

    func encode(to encoder: Encoder) throws {
        throw FirestoreEncodingError.encodingIsNotSupported(
            "DocumentID values can only be encoded with Firestore.Encoder"
        )
    }
}

@propertyWrapper
struct ID: DocumentIDProtocol, Codable, Hashable {
    public var wrappedValue: DocumentReference?
    
    var existsInFirestore: Bool {
        wrappedValue != nil
    }

    public init(wrappedValue value: DocumentReference?) {
        wrappedValue = value
    }

    // MARK: - `DocumentIDProtocol` conformance

    init(from documentReference: DocumentReference?) {
        wrappedValue = documentReference
    }

    // MARK: - `Codable` implementation.

    init(from decoder: Decoder) throws {
        throw FirestoreDecodingError.decodingIsNotSupported(
            "DocumentID values can only be decoded with Firestore.Decoder"
        )
    }

    func encode(to encoder: Encoder) throws {
        throw FirestoreEncodingError.encodingIsNotSupported(
            "DocumentID values can only be encoded with Firestore.Encoder"
        )
    }
}

@propertyWrapper
class Ref<T: Model> {
    var documentReference: DocumentReference?
    var wrappedValue: T? = nil
    var listener: ListenerRegistration? = nil
    
    func load() {
        documentReference?.getDocument { snapshot, error in
            guard let snapshot = snapshot else {
                print(error!)
                return
            }
            
            do {
                self.wrappedValue = try snapshot.data(as: T.self)
            } catch {
                print(error)
            }
        }
    }
    
    func live() {
        guard listener == nil else { return }
        
        listener = documentReference?.addSnapshotListener { snapshot, error in
            guard let snapshot = snapshot else {
                print(error!)
                return
            }
            
            do {
                self.wrappedValue = try snapshot.data(as: T.self)
            } catch {
                print(error)
            }
        }
    }
    
    deinit {
        listener?.remove()
    }
}
