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
                    destination: Lazy(ChatRoom(room))
                ) {
                    Text(room.title)
                }
            }
            .listStyle(SidebarListStyle())
            .toolbar {
                Button(action: toggleSidebar) {
                    Label("Toggle sidebar", systemImage: "sidebar.left")
                }
            }
        }
        .environment(\.currentUser, "Evert")
    }
    
    func toggleSidebar() {
        NSApp.keyWindow?.firstResponder?
            .tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
    }
}

struct macOSView_Previews: PreviewProvider {
    static var previews: some View {
        macOSView()
    }
}

struct Lazy<Content: View>: View {
    let build: () -> Content
    
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    
    var body: Content {
        build()
    }
}
