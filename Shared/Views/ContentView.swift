//
//  ContentView.swift
//  Shared
//
//  Created by Evert van Brussel on 23/07/2020.
//

import Firebase
import FirebaseFirestore
import Foundation
import SwiftUI

struct ContentView: View {
    /// This is all the messages from Firestore, ordered by their created date.
    @Collection({ $0.order(by: "created") })
    private var messages: [Message]
    
    @StateObject // To observe the keyboard height
    private var keyboard = KeyboardResponder()
    
    @State
    private var currentUser: String = "Evert" // for testing purposes
    
    var body: some View {
        VStack {
            if currentUser == "" {
                SignIn(currentUser: $currentUser)
            } else {
                Chat(messages: messages)
            }
        }
        // We use this padding to slide the view up
        // when the keyboard becomes visible.
        .padding(.bottom, keyboard.currentHeight)
        .edgesIgnoringSafeArea(keyboard.currentHeight > 0 ? .bottom : [])
        .animation(.easeOut(duration: 0.16))
        .environment(\.currentUser, currentUser)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
