import XcodeServer
import Dispatch
#if canImport(CoreData)
import CoreData

public class CoreDataStore {
    
    public let persistentContainer: NSPersistentContainer
    internal let internalQueue: DispatchQueue = DispatchQueue(label: "XcodeServer.XcodeServerCoreData.CoreDataStore")
    internal let returnQueue: DispatchQueue
    
    /// Initializes the `CoreData` persistent container.
    ///
    /// - parameter model: `Model` version the store should be initialized with. (Migration if needed/able)
    /// - parameter dispatchQueue: DispatchQueue on which all results will be returned (when not specified).
    /// - parameter persisted: When false, this store will only be maintained in memory.
    public init(model: Model, dispatchQueue: DispatchQueue = .main, persisted: Bool = true) {
        persistentContainer = NSPersistentContainer(model: model, persisted: persisted)
        returnQueue = dispatchQueue
    }
}

extension CoreDataStore: AnyQueryable {
}

extension CoreDataStore: AnyPersistable {
}
#endif
