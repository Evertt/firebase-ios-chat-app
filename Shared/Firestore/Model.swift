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
    var id: String { get }
}

extension Model {
    private static var colRef: CollectionReference {
        Firestore.firestore().collection(Self.collectionPath)
    }
    
    var docRef: DocumentReference {
        return Self.colRef.document(id)
    }
    
    var _id: MyDocumentID {
        guard let id = Mirror(reflecting: self).descendant("_id") as? MyDocumentID else {
            fatalError("id property must be declared using @MyDocumentID")
        }
        return id
    }
    
    var existsInFirestore: Bool {
        _id.existsInFirestore
    }
    
    /// Delete this model from Firestore.
    func delete() {
        docRef.delete()
    }
    
    /// Save this model in Firestore, either as a new document or by updating the existing one.
    func save() {
        do {
            try docRef.setData(from: self)
        } catch {
            print(error)
        }
    }
}
