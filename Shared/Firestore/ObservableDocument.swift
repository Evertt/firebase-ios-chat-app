import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

class ObservableDocument<ModelType: Model>: ObservableObject {
    @Published var model: ModelType
    
    var listener: ListenerRegistration? = nil
    
    init(model: ModelType) {
        self.model = model
        
        // We subscribe to live snapshots on the query
        listener = Firestore.firestore()
            .collection(ModelType.collectionPath)
            .document(model.id!.documentID)
            .addSnapshotListener { snapshot, error in
                guard let snapshot = snapshot else {
                    print(error!)
                    return
                }

                // And fill / replace our models array with
                // the results from every new snapshot.
                do {
                    if let model = try snapshot.data(as: ModelType.self) {
                        self.model = model
                    } else {
                        print("Document did not exist.")
                    }
                } catch {
                   print(error)
                }
            }
    }
    
    deinit {
        listener?.remove()
    }
}
