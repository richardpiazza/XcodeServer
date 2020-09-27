import Dispatch
#if canImport(CoreData)
import CoreData

public class CoreDataStore {
    
    public let persistentContainer: NSPersistentContainer
    public let dispatchQueue: DispatchQueue = DispatchQueue(label: "XcodeServer.XcodeServerCoreData.CoreDataStore")
    
    /// Initializes the `CoreData` persistent container.
    ///
    /// - parameter model: `Model` version the store should be initialized with. (Migration if needed/able)
    /// - parameter persisted: When false, this store will only be maintained in memory.
    public init(model: Model, persisted: Bool = true) {
        persistentContainer = NSPersistentContainer(model: model, persisted: persisted)
    }
    
}
#endif
