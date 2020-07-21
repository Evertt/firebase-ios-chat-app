//
//  Firestore.swift
//  tryout
//
//  Created by Evert van Brussel on 19/07/2020.
//  Copyright © 2020 Evert van Brussel. All rights reserved.
//

import SwiftUI
import FirebaseFirestore

@propertyWrapper
struct Store<ModelType: Model>: DynamicProperty {
    @ObservedObject var observable: ObservableCollection<ModelType>
    public var wrappedValue: [ModelType] { observable.models }
    
    init(_ queryBuilder: ((CollectionReference) -> Query)? = nil) {
        let collectionReference = Firestore.firestore().collection(ModelType.collectionPath)
        let query = queryBuilder?(collectionReference) ?? collectionReference

        observable = ObservableCollection(collectionReference: collectionReference, query: query)
    }
}
