import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

fileprivate struct WeakAnyObservableCollection {
    weak var collection: AnyObservableCollection?
    
    init(_ collection: AnyObservableCollection) {
        self.collection = collection
    }
}

fileprivate class ObservableCollections: Swift.MutableCollection {
    private var _collections: [WeakAnyObservableCollection]
    
    private var collections: [AnyObservableCollection] {
        get { _collections.compactMap { $0.collection } }
        set { _collections = newValue.map(WeakAnyObservableCollection.init) }
    }
    
    public var startIndex: Int { collections.startIndex }
    public var endIndex: Int { collections.endIndex }

    init(_ collections: [AnyObservableCollection] = []) {
        _collections = collections.map(WeakAnyObservableCollection.init)
    }
    
    public subscript(index: Int) -> AnyObservableCollection {
        get { collections[index] }
        set { collections[index] = newValue }
    }

    public func index(after i: Int) -> Int {
        return collections.index(after: i)
    }
    
    public func append(_ collection: AnyObservableCollection) {
        collections.append(collection)
    }
}

fileprivate struct Storage {
    static var collections = [ObjectIdentifier:ObservableCollections]()
    static var listeners = [ObjectIdentifier:[Query:ListenerRegistration]]()
    static var models = [Query:[Any]]()
    
    static func listen<M: Model>(to query: Query, for collection: AnyObservableCollection, type: M.Type = M.self) {
        let typeID = ObjectIdentifier(type)
        
        if let listener = listeners[typeID]?[query] {
            let listenerID = ObjectIdentifier(listener)
            collections[listenerID, default: .init()].append(collection)
            collection.setModels(models[query, default: []])
            return
        }
        
        let listener = query.addSnapshotListener { snapshot, error in
            guard let docs = snapshot?.documents else {
                track(error!)
                return
            }
            
            // And fill / replace our models array with
            // the results from every new snapshot.
            models[query] = docs.compactMap {
                do {
                    return try $0.data(as: M.self)
                } catch {
                    track("Error for document \($0.documentID): \(error)")
                    return nil
                }
            } as [M]
            
            let collections = listeners[typeID]?[query]
                .map(ObjectIdentifier.init)
                .flatMap { self.collections[$0] }
            
            if let collections = collections {
                for collection in collections {
                    collection.setModels(models[query, default: []])
                }
            }
        }
        
        let listenerID = ObjectIdentifier(listener)
        listeners[typeID, default: [:]][query] = listener
        collections[listenerID] = ObservableCollections([collection])
    }
}

fileprivate protocol AnyObservableCollection: AnyObject {
    func setModels(_ models: [Any])
}

class ObservableCollection<ModelType: Model>: ObservableObject, AnyObservableCollection {
    @Published var models = [ModelType]()
    
    init() {}
    
    init(query: Query) {
        Storage.listen(to: query, for: self, type: ModelType.self)
    }
    
    func setModels(_ models: [Any]) {
        self.models = models.compactMap {
            $0 as? ModelType
        }
    }
}
