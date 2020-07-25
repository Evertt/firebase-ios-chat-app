import SwiftUI
import Foundation

struct Chat: View {
    let messages: [Message]
    @Environment(\.currentUser) var me
    @State private var draftMessage = Message()
    @State private var draftBackup = Message()
    
    var body: some View {
        Group {
            LazyUpsideDownVScroll(messages) { message in
                Bubble(message: message, startEditing: self.startEditing)
                    .padding(.top, 10)
            }
            
            if draftMessage.existsInFirestore {
                Text("Editing:")
                    .padding(.top)
                    .transition(AnyTransition
                                    .move(edge: .bottom)
                                    .combined(with: .opacity)
                    )
            }
            
            TextField("Write message", text: $draftMessage.body, onCommit: submitMessage)
                .padding()
                .onExitCommand(perform: resetMessage)
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
        
        resetMessage()
    }
    
    func resetMessage() {
        draftMessage = draftBackup
        draftBackup = Message()
    }
}
