import SwiftUI

struct Bubble: View {
    let message: Message
    let startEditing: (Message) -> ()
    @Environment(\.currentUser) var me
    var isMe: Bool { message.author == me }
    
    var body: some View {
        VStack(alignment: .leading) {
            // Only show the author's name
            // if the author isn't me.
            if !isMe {
                Text(message.author)
                    .font(.headline)
            }
            
            Text(message.body)
        }
        .padding()
        /// Make *my* bubbles light green and *their* bubbles light gray.
        .background(isMe ? Color.green.opacity(0.4) : Color.gray.opacity(0.1))
        .foregroundColor(Color.black.opacity(0.7))
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.15), radius: 1, x: 0.5, y: 0.5)
        .frame(
                width: 350,
                height: nil,
                /// Put *my* messages on the right,
                /// and *their* messages on the left.
                alignment: isMe ? .trailing : .leading
        )
        .contextMenu(!isMe ? nil : ContextMenu {
            Button(action: message.delete) {
                Text("Delete")
                Image(systemName: "trash")
            }
            
            Button(action: { self.startEditing(self.message) }) {
                Text("Edit")
                Image(systemName: "pencil")
            }
        })
    }
}
