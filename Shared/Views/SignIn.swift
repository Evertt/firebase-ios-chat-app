import SwiftUI

struct SignIn: View {
    @Binding var currentUser: String
    @State private var newName: String = ""
    
    var body: some View {
        HStack {
            Spacer(minLength: 60)
            TextField(
                "Fill in your name and press return",
                text: $newName, onCommit: submitName
            )
            Spacer(minLength: 60)
        }
    }
    
    func submitName() {
        guard newName != "" else {
            return
        }
        
        currentUser = newName
        newName = ""
    }
}
