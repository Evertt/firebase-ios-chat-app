//
//  DocumentID+Hashable.swift
//  tryout
//
//  Created by Evert van Brussel on 23/07/2020.
//

import FirebaseFirestoreSwift

extension DocumentID: Hashable where Value: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(wrappedValue)
    }
}
