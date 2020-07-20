//
//  Message.swift
//  tryout
//
//  Created by Evert van Brussel on 20/07/2020.
//  Copyright © 2020 Evert van Brussel. All rights reserved.
//

import Foundation
import FirebaseFirestoreSwift

struct Message: Codable, Identifiable {
    @DocumentID
    var id: String?
    let author: String
    let body: String
    let created: Date
}
