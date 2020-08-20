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
class Ref<T: Model>: Codable, Hashable, ObservableObject {
    static func == (lhs: Ref<T>, rhs: Ref<T>) -> Bool {
        return lhs.documentReference?.documentID == rhs.documentReference?.documentID
    }
    
    var documentReference: DocumentReference?
    @Published var listener: ListenerRegistration? = nil
    var model: T? = nil
    
    var wrappedValue: T? {
        get {
            if listener == nil {
                startListening()
            }
            
            return model
        }
        
        set {
            if newValue?.id != model?.id {
                listener?.remove()
                listener = nil
            }
            
            model = newValue
        }
    }
    
    var existsInFirestore: Bool {
        documentReference != nil
    }
    
    public init(wrappedValue value: T?) {
        model = value
        documentReference = model?.id
    }

    required init(from decoder: Decoder) throws {
        let decoder = decoder as! _FirestoreDecoder
        documentReference = try decoder.decode(DocumentReference.self)
    }
    
    func startListening() {
        guard listener == nil else { return }
        
        if let documentReference = documentReference {
            track("\nListening to \(documentReference.documentID)")
        }
        
        listener = documentReference?.addSnapshotListener { snapshot, error in
            guard let snapshot = snapshot else {
                track(error!)
                return
            }
            
            track("\nSnapshot: \(snapshot.data()!)")
            
            do {
                self.model = try snapshot.data(as: T.self)
            } catch {
                track(error)
            }
        }
    }

    func encode(to encoder: Encoder) throws {
        try documentReference.encode(to: encoder)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(documentReference?.documentID)
    }
    
    deinit {
        listener?.remove()
    }
}
