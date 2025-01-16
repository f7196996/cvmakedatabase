import CoreData

public class PersistenceContainer: NSPersistentContainer, ObservableObject {
    public static let shared = PersistenceContainer()
    private var savingQueue = OperationQueue()
    
    public init(inMemory: Bool = false) {
        guard let url = Bundle.module.url(forResource: "JinTonikCD", withExtension: "momd") else {
            fatalError("No database found")
        }
        
        guard let model = NSManagedObjectModel.init(contentsOf: url) else {
            fatalError("Can't load managed object models from bundle")
        }
        
        super.init(name: "JinTonikCD", managedObjectModel: model)
        
        if inMemory {
            if let persistentStoreDescription = persistentStoreDescriptions.first {
                persistentStoreDescription.url = URL(fileURLWithPath: "/dev/null")
            }
        } else {
            viewContext.mergePolicy = NSOverwriteMergePolicy
            viewContext.automaticallyMergesChangesFromParent = true
        }
        
        loadPersistentStores(completionHandler: { (store, error) in
            if let error: NSError = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })    
    }
}

extension PersistenceContainer {
    public func saveChanges(_ completion: ((Error?) -> Void)? = nil) {
        let operation = BlockOperation { [unowned self] in
            do {
                if viewContext.hasChanges {
                    try viewContext.save()
                }
                completion?(nil)
            } catch {
                completion?(error)
            }
        }
        
        savingQueue.addOperations([operation], waitUntilFinished: false)
    }
}
