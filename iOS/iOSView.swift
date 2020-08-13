//
//  ContentView.swift
//  tryout (iOS)
//
//  Created by Evert van Brussel on 25/07/2020.
//

import SwiftUI

struct iOSView: View {
    @Collection({ $0.order(by: "title") })
    private var rooms: [Room]
    
    var body: some View {
        NavigationView {
            List(rooms) { room in
                NavigationLink(
                    destination: KeyboardAwareView { ChatRoom(room) }
                ) {
                    Text(room.title)
                }
            }
            .navigationBarTitle("Rooms")
        }
        .environment(\.currentUser, "Evert")
    }
}

struct iOSView_Previews: PreviewProvider {
    static var previews: some View {
        iOSView()
    }
}
