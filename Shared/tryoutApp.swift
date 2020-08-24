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
            #if os(iOS)
                iOSView()
            #else
                macOSView()
            #endif
        }
    }
}

struct tryoutApp_Previews: PreviewProvider {
    static var previews: some View {
        #if os(iOS)
            iOSView()
                .environment(\.colorScheme, .dark)
        #else
            macOSView()
                .environment(\.colorScheme, .dark)
        #endif
    }
}
