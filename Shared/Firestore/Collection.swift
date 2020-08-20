//
//  Firestore.swift
//  tryout
//
//  Created by Evert van Brussel on 19/07/2020.
//  Copyright © 2020 Evert van Brussel. All rights reserved.
//

import SwiftUI
import FirebaseFirestore

/**
    This property wrapper subscribes to the live snapshots of a `Firestore` collection / query.
    And whenever a new snapshot comes in, it updates the wrapped `[Model]` value.
 */
@propertyWrapper
struct Collection<ModelType: Model>: DynamicProperty {
    @ObservedObject var observable: ObservableCollection<ModelType>
    public var wrappedValue: [ModelType] { observable.models }
    
    public var projectedValue: Binding<[ModelType]> {
        $observable.models
    }
    
    /**
        - Parameter queryBuilder: An optional closure to build a query with, for the store to subscribe to.
                                  If omitted then the store will simply subscribe to the collection as a whole.
     */
    init(_ queryBuilder: ((CollectionReference) -> Query)? = nil) {
        let collectionReference = Firestore.firestore().collection(ModelType.collectionPath)
        let query = queryBuilder?(collectionReference) ?? collectionReference

        observable = ObservableCollection(collectionReference: collectionReference, query: query)
    }
    
    init(wait: Bool) {
        if wait {
            observable = ObservableCollection()
        } else {
            self = .init()
        }
    }
}
