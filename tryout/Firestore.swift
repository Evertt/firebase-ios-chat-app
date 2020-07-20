//
//  Firestore.swift
//  tryout
//
//  Created by Evert van Brussel on 19/07/2020.
//  Copyright © 2020 Evert van Brussel. All rights reserved.
//

import SwiftUI
import FirebaseFirestore

class Observable<T: Codable>: ObservableObject {
    @Published var value = [T]()
    
    let query: Query
    var listener: ListenerRegistration? = nil
    
    init(_ query: Query) {
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
            let _ = try query.collection.addDocument(from: document)
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
    
    init(_ q: Query) {
        self.observable = Observable(q)
    }
    
    public mutating func update() {
        _observable.update()
    }
    
    public func add(_ document: T) {
        observable.add(document)
    }
}
