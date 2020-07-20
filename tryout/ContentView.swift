//
//  ContentView.swift
//  tryout
//
//  Created by Evert van Brussel on 19/07/2020.
//  Copyright © 2020 Evert van Brussel. All rights reserved.
//

import FirebaseFirestore
import Foundation
import SwiftUI

struct CurrentUser: EnvironmentKey {
    static var defaultValue: String = ""
}

extension EnvironmentValues {
    var currentUser: String {
        get { self[CurrentUser.self] }
        set { self[CurrentUser.self] = newValue }
    }
}

extension View {
    public func flip() -> some View {
        return self
            .rotationEffect(.radians(.pi))
            .scaleEffect(x: -1, y: 1, anchor: .center)
    }
}

struct Bubble: View {
    @Environment(\.currentUser) var me
    let message: Message
    
    var body: some View {
        VStack(alignment: .leading) {
            if message.author != me {
                Text(message.author)
                    .font(.headline)
            }
            
            Text(message.body)
        }
        .foregroundColor(.white)
        .padding()
        .background(Color.blue)
        .cornerRadius(10)
        .frame(
                width: 350,
                height: nil,
                alignment: message.author == me ? .trailing : .leading
        )
    }
}

struct Chat: View {
    let messages: [Message]
    
    init(_ messages: [Message]) {
        self.messages = messages
        
        UITableView.appearance().tableFooterView = UIView()
        UITableView.appearance().separatorStyle = .none
    }
    
    var body: some View {
        List(messages.reversed()) { message in
            Bubble(message: message)
            .flip()
        }
        .flip()
    }
}

struct ContentView: View {
    @Store("messages", { $0.order(by: "created") })
    var messages: [Message]
    
    @ObservedObject private var keyboard = KeyboardResponder()
    
    @State var me: String = ""
    @State private var name: String = ""
    @State private var message: String = ""
    
    var body: some View {
        VStack {
            if me == "" {
                HStack {
                    Spacer(minLength: 60)
                    TextField("What is your name?", text: $name, onCommit: submitName)
                    Spacer(minLength: 60)
                }
            } else {
                Chat(messages)
                HStack {
                    TextField("Write message", text: $message, onCommit: sendMessage)
                        .padding()
                }
            }
        }
        .padding(.bottom, keyboard.currentHeight)
        .edgesIgnoringSafeArea(keyboard.currentHeight > 0 ? .bottom : [])
        .animation(.easeOut(duration: 0.16))
        .environment(\.currentUser, me)
    }
    
    func submitName() {
        guard name != "" else { return }
        
        me = name
        name = ""
    }
    
    func sendMessage() {
        guard message != "" else { return }
        
        let message = Message(
            author: me,
            body: self.message,
            created: Date()
        )
        
        _messages.add(message)
        
        self.message = ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
