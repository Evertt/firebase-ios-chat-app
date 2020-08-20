import FirebaseFirestore
import FirebaseFirestoreSwift

/**
    You need to conform your models to this protocol so that the
    `Store` property wrapper can use them with Firebase's firestore.
 */
protocol Model: Codable, Identifiable, Hashable {
    /// The path to the collection in Firestore.
    static var collectionPath: String { get }
    
    /// The document id from Firestore. If this model has not yet been added to Firestore then the id will be nil.
    var id: DocumentReference? { get }
}

extension Model {
    private static var colRef: CollectionReference {
        Firestore.firestore().collection(Self.collectionPath)
    }
    
    var existsInFirestore: Bool {
        id != nil
    }
    
    /// Delete this model from Firestore.
    func delete() {
        id?.delete()
    }
    
    /// Save this model in Firestore, either as a new document or by updating the existing one.
    func save() {
        do {
            if let docRef = id {
                try docRef.setData(from: self)
            } else {
                let _ = try Self.colRef.addDocument(from: self)
            }
        } catch {
            track(error)
        }
    }
}
