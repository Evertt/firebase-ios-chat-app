import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

class ObservableCollection<ModelType: Model>: ObservableObject {
    @Published var models = [ModelType]()
    
    private var listener: ListenerRegistration? = nil
    
    init() {}
    
    init(collectionReference: CollectionReference, query: Query) {
        // We subscribe to live snapshots on the query
        listener = query.addSnapshotListener { snapshot, error in
            guard let docs = snapshot?.documents else {
                track(error!)
                return
            }
            
            track("Snapshot from \(collectionReference.collectionID)")
            
            // And fill / replace our models array with
            // the results from every new snapshot.
            self.models = docs.compactMap {
                do {
                    return try $0.data(as: ModelType.self)
                } catch {
                    track("Error for document \($0.documentID): \(error)")
                    return nil
                }
            }
        }
        
        track("Listener initialized \(listener as Any)")
    }
    
    deinit {
        track("Deinitialized \(ModelType.self) \(listener as Any)")
        listener?.remove()
    }
}
