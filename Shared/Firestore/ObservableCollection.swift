import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

class ObservableCollection<ModelType: Model>: ObservableObject {
    @Published var models = [ModelType]()
    
    var listener: ListenerRegistration? = nil
    
    init(collectionReference: CollectionReference, query: Query) {
        // We subscribe to live snapshots on the query
        listener = query.addSnapshotListener { snapshot, error in
            guard let docs = snapshot?.documents else {
                print(error!)
                return
            }
            
            // And fill / replace our models array with
            // the results from every new snapshot.
            self.models = docs.compactMap {
                try? $0.data(as: ModelType.self)
            }
        }
    }
    
    deinit {
        listener?.remove()
    }
}
