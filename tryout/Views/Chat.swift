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
            .flip()
            
            HStack {
                TextField("Write message", text: $message.body, onCommit: sendMessage)
                    .padding()
            }
        }
    }
    
    func startEditing(message: Message) {
        self.message = message
    }
    
    func sendMessage() {
        guard message.body != "" else {
            return
        }
        
        message.author = me
        message.created = Date()
        
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
