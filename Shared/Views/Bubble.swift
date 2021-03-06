import SwiftUI

struct Bubble: View {
    /// The message in the bubble
    let message: Message
    
    /// To communicate to the chat view
    /// that we want to edit this message
    let startEditing: (Message) -> ()
    
    @Environment(\.currentUser) var me
    var isMe: Bool { message.author == me }
    
    /// The standard duration of all animations
    @Environment(\.animationDuration) var duration
    
    var body: some View {
        VStack(alignment: .leading) {
            // Only show the author's name
            // if the author isn't me.
            if !isMe {
                Text(message.author)
                    .font(.footnote)
                    .fontWeight(.bold)
                    .padding(.bottom, 2)
            }
            
            Text(message.body)
        }
        .padding()
        /// Make *my* bubbles light green and *their* bubbles light gray.
        .background(isMe ? Color.systemGreen.opacity(0.4) : Color.quaternary.opacity(0.8))
        .foregroundColor(Color.primary.opacity(0.8))
        .cornerRadius(10)
        .shadow(color: Color.primary.opacity(0.25), radius: 1, x: 0.5, y: 0.5)
        .contextMenu(!isMe ? nil : ContextMenu {
            Button(action: delayed(duration, { startEditing(message) })) {
                Text("Edit")
                Image(systemName: "pencil")
            }
            
            Button(action: delayed(duration, message.delete)) {
                Text("Delete")
                Image(systemName: "trash")
            }
        })
        .padding(isMe ? .leading : .trailing, 40)
        .padding(isMe ? .trailing : .leading, 20)
        .frame(
                maxWidth: .infinity,
                /// Put *my* messages on the right,
                /// and *their* messages on the left.
                alignment: isMe ? .trailing : .leading
        )
    }
}
