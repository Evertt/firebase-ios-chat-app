//
//  Firestore.swift
//  tryout
//
//  Created by Evert van Brussel on 19/07/2020.
//  Copyright © 2020 Evert van Brussel. All rights reserved.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

class Observable<T: Codable>: ObservableObject {
    @Published var value = [T]()
    
    let collectionReference: CollectionReference
    let query: Query
    var listener: ListenerRegistration? = nil
    
    init(collectionReference: CollectionReference, query: Query) {
        self.collectionReference = collectionReference
        self.query = query
        
        listener = self.query.addSnapshotListener { snapshot, error in
            guard let docs = snapshot?.documents else {
                print(error!)
                return
            }
            
            self.value = docs.compactMap {
                try? $0.data(as: T.self)
            }
        }
    }
    
    func add(_ document: T) {
        do {
            let _ = try collectionReference.addDocument(from: document)
        } catch {
            print(error)
        }
    }
    
    deinit {
        listener?.remove()
    }
}

@propertyWrapper
struct Store<T: Codable>: DynamicProperty {
    @ObservedObject var observable: Observable<T>
    
    public private(set) var wrappedValue: [T] {
        get { observable.value }
        set {
            observable.value = newValue
        }
    }
    
    public var projectedValue: Binding<[T]> {
        $observable.value
    }
    
    init(_ collectionPath: String, _ queryBuilder: (CollectionReference) -> Query) {
        let collectionReference = Firestore.firestore().collection(collectionPath)
        let query = queryBuilder(collectionReference)

        observable = Observable(collectionReference: collectionReference, query: query)
    }
    
    public mutating func update() {
        _observable.update()
    }
    
    public func add(_ document: T) {
        observable.add(document)
    }
}
