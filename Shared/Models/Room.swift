import FirebaseFirestore
import FirebaseFirestoreSwift

struct Room: Model {
    @DocumentID
    var id: DocumentReference? = nil
    var title: String
    var description: String

    static let collectionPath: String = "rooms"
    
    func draftMessage(author: String = "", body: String = "") -> Message {
        return Message(author: author, body: body, room: self)
    }
}
