//
//  UpsideDownScrollView.swift
//  tryout
//
//  Created by Evert van Brussel on 25/07/2020.
//

import SwiftUI

struct KeyboardAwareView<Content>: View where Content : View {
    @StateObject private var keyboard = KeyboardObserver()
    
    let content: () -> Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        content()
            // We use this padding to slide the view up
            // when the keyboard becomes visible.
            .padding(.bottom, keyboard.currentHeight)
            .edgesIgnoringSafeArea(keyboard.currentHeight > 0 ? .bottom : [])
            .animation(.easeOut(duration: 0.16))
    }
}
