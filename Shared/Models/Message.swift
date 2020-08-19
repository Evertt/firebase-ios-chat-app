//
//  Message.swift
//  tryout
//
//  Created by Evert van Brussel on 20/07/2020.
//  Copyright © 2020 Evert van Brussel. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Message: Model {
    static let collectionPath: String = "messages"
    
    @DocumentID
    var id: DocumentReference? = nil
    var author: String = ""
    var body: String = ""
    var created: Date = Date()
    @Ref var room: Room?
}
