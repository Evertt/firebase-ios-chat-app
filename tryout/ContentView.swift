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

extension View {
    public func flip() -> some View {
        return self
            .rotationEffect(.radians(.pi))
            .scaleEffect(x: -1, y: 1, anchor: .center)
    }
}

struct Bubble: View {
    let message: Message
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(message.author)
                .font(.headline)
            Text(message.body)
        }
        .foregroundColor(.white)
        .padding()
        .background(Color.blue)
        .cornerRadius(10)
    }
}

struct Chat: View {
    let author = "Evert"
    let messages: [Message]
    
    init(_ messages: [Message]) {
        self.messages = messages
        
        UITableView.appearance().tableFooterView = UIView()
        UITableView.appearance().separatorStyle = .none
    }
    
    var body: some View {
        List(messages.reversed()) { message in
            Bubble(message: message)
                .frame(
                    width: 350,
                    height: nil,
                    alignment: message.author == self.author
                        ? .trailing : .leading
            )
            .flip()
        }
        .flip()
    }
}

struct ContentView: View {
    @Store("messages", { $0.order(by: "created") })
    var messages: [Message]
    
    @State private var message: String = ""
    
    var body: some View {
        VStack {
            Chat(messages)
            HStack {
                TextField("Write message", text: $message, onCommit: sendMessage)
                    .padding()
            }
        }
    }
    
    func sendMessage() {
        let message = Message(
            author: "Evert",
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
