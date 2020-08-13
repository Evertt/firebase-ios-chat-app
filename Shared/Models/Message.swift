//
//  Message.swift
//  tryout
//
//  Created by Evert van Brussel on 20/07/2020.
//  Copyright © 2020 Evert van Brussel. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct Message: Model {
    @MyDocumentID
    var id: String
    var author: String = ""
    var body: String = ""
    var created: Date = Date()
    var room: DocumentReference
    
    init(
        id: String = UUID().description,
        author: String = "", body: String = "",
        room: DocumentReference,
        created: Date = Date()
    ) {
        self.id = id
        self.author = author
        self.body = body
        self.room = room
        self.created = created
    }
    
    static let collectionPath: String = "messages"
}
