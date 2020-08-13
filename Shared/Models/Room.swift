//
//  Message.swift
//  tryout
//
//  Created by Evert van Brussel on 20/07/2020.
//  Copyright © 2020 Evert van Brussel. All rights reserved.
//

struct Room: Model {
    @MyDocumentID
    var id: String
    var title: String
    var description: String

    static let collectionPath: String = "rooms"
    
    func draftMessage(author: String = "", body: String = "") -> Message {
        return Message(author: author, body: body, room: _id.docRef!)
    }
}
