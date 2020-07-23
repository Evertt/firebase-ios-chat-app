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
    This property wrapper subscribes to the live snapshots of a `Firestore` document.
    And whenever a new snapshot comes in, it updates the wrapped `Model` value.
 */
@propertyWrapper
struct Document<ModelType: Model>: DynamicProperty {
    @ObservedObject var observable: ObservableDocument<ModelType>
    public var wrappedValue: ModelType { observable.model }
    
    init(wrappedValue: ModelType) {
        observable = ObservableDocument(model: wrappedValue)
    }
}
