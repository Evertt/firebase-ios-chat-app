import SwiftUI

struct Bubble: View {
    @Environment(\.currentUser) var me
    let message: Message
    let startEditing: (Message) -> ()
    
    var isMe: Bool {
        message.author == me
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            if !isMe {
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
