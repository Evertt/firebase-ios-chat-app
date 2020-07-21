import SwiftUI

struct SignIn: View {
    @Binding var me: String
    @State private var newName: String = ""
    
    var body: some View {
        HStack {
            Spacer(minLength: 60)
            TextField("What is your name?", text: $newName, onCommit: submitName)
            Spacer(minLength: 60)
        }
    }
    
    func submitName() {
        guard newName != "" else {
            return
        }
        
        me = newName
        newName = ""
    }
}
