//
//  macOSView.swift
//  tryout
//
//  Created by Evert van Brussel on 10/08/2020.
//

import SwiftUI

struct macOSView: View {
    @Collection({ $0.order(by: "title") })
    private var rooms: [Room]
    
    var body: some View {
        NavigationView {
            List(rooms) { room in
                NavigationLink(
                    destination: ChatRoom(room)
                ) {
                    Text(room.title)
                }
            }
        }
        .environment(\.currentUser, "Evert")
    }
}

struct macOSView_Previews: PreviewProvider {
    static var previews: some View {
        macOSView()
    }
}
