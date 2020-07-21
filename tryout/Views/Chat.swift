import SwiftUI

struct Chat: View {
    let messages: [Message]
    @Environment(\.currentUser) var me
    @State private var message = Message()
    
    init(_ messages: [Message]) {
        self.messages = messages
        
        UITableView.appearance().tableFooterView = UIView()
        UITableView.appearance().separatorStyle = .none
    }
    
    var body: some View {
        Group {
            List(messages.reversed()) { message in
                Bubble(message: message, startEditing: self.startEditing)
                    .flip()
            }
                // I use the flipping to make the list
                // automatically scroll to the bottom.
                .flip()
            
            TextField("Write message", text: $message.body, onCommit: sendMessage)
                .padding()
        }
    }
    
    func startEditing(messageToEdit: Message) {
        self.message = messageToEdit
    }
    
    func sendMessage() {
        guard message.body != "" else {
            return
        }
        
        message.author = me
        
        // We don't want to set the created date
        // if the message is an existing one.
        // I.e. when we're *editing* a message.
        if message.id == nil {
            message.created = Date()
        }
        
        // this works both for adding a new message
        // and for editing an existing message
        message.save()
        
        // If we were editing a message,
        // then it had an id. We empty the id,
        // so that the state goes back
        // to writing a new message.
        message.id = nil
        message.body = ""
    }
}

extension View {
    public func flip(_ flip: Bool = true) -> some View {
        return self
            .rotationEffect(.radians(flip ? .pi : 0))
            .scaleEffect(x: flip ? -1 : 1, y: 1, anchor: .center)
    }
}
