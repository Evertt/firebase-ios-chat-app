//
//  tryoutApp.swift
//  Shared
//
//  Created by Evert van Brussel on 23/07/2020.
//

import SwiftUI
import Firebase

@main
struct tryoutApp: App {
    init() {
        Firebase.FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
