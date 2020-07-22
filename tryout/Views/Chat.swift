import SwiftUI

struct Chat: View {
    let messages: [Message]
    @Environment(\.currentUser) var me
    @State private var draftMessage = Message()
    @State private var draftBackup = Message()
    
    init(_ messages: [Message]) {
        self.messages = messages
        
        // These lines remove the separator lines in the list view.
        UITableView.appearance().tableFooterView = UIView()
        UITableView.appearance().separatorStyle = .none
    }
    
    var body: some View {
        Group {
            List(messages.reversed()) { message in
                Bubble(message: message, startEditing: self.startEditing)
                    .flip()
            }
                // I flip the list and all its items
                // so that it automatically scrolls to the bottom.
                .flip()
            
            if draftMessage.existsInFirestore {
                Text("Editing:")
            }
            
            TextField("Write message", text: $draftMessage.body, onCommit: submitMessage)
                .padding()
        }
    }
    
    func startEditing(messageToEdit: Message) {
        // We backup whatever message the user was writing.
        // So that the user can continue with that message
        // when they're done editing this message.
        draftBackup = draftMessage
        draftMessage = messageToEdit
    }
    
    /// Submit a new message or an edited existing message.
    func submitMessage() {
        guard draftMessage.body != "" else {
            return
        }
        
        draftMessage.author = me
        
        // If this message does not yet
        // exist in Firestore, then we want
        // to set the created date to now.
        if !draftMessage.existsInFirestore {
            draftMessage.created = Date()
        }
        
        draftMessage.save()
        
        draftMessage = draftBackup
        draftBackup = Message()
    }
}

extension View {
    public func flip(_ flip: Bool = true) -> some View {
        return self
            .rotationEffect(.radians(flip ? .pi : 0))
            .scaleEffect(x: flip ? -1 : 1, y: 1, anchor: .center)
    }
}
