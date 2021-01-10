import XcodeServer
#if canImport(CoreData)
import CoreData

public protocol CoreDataContainer: AnyQueryable, AnyPersistable {
    var persistentContainer: NSPersistentContainer { get }
    static var model: Model { get }
    static var managedObjectModel: NSManagedObjectModel { get }
    static var mappingModel: NSMappingModel? { get }
}

public extension CoreDataContainer {
    var path: String? {
        persistentContainer.persistentStoreCoordinator.persistentStores.first?.url?.path
    }
    
    /// Removed all stores from the `persistentStoreCoordinator`
    ///
    /// **WARNING**: The container & related context will be un-usable until a store has been reloaded.
    func unload() {
        for store in persistentContainer.persistentStoreCoordinator.persistentStores {
            do {
                try persistentContainer.persistentStoreCoordinator.remove(store)
            } catch {
                InternalLog.coreData.error("Failed to remove persistent store from the store coordinator.", error: error)
            }
        }
    }
}

#endif
