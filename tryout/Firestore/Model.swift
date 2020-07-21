import FirebaseFirestore

protocol Model: Codable, Identifiable {
    static var collectionPath: String { get }
    var id: String? { get }
}

extension Model {
    static var colRef: CollectionReference {
        Firestore.firestore().collection(Self.collectionPath)
    }
    
    var docRef: DocumentReference? {
        guard let id = id else { return nil }
        return Self.colRef.document(id)
    }
    
    func delete() {
        docRef?.delete()
    }
    
    func save() {
        do {
            if let docRef = docRef {
                try docRef.setData(from: self)
            } else {
                let _ = try Self.colRef.addDocument(from: self)
            }
        } catch {
            print(error)
        }
    }
}
