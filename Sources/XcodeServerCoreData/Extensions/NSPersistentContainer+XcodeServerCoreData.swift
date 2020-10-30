import XcodeServer
import Foundation
#if canImport(CoreData)
import CoreData

extension NSPersistentContainer {
    /// Initializes the `NSPersistentContainer` with a specified `Model` version.
    ///
    /// If an existing store exists and the default URL, a _heavyweight_ migration will be performed. Any existing store
    /// will be removed if the migration fails due to:
    /// * `Migration.Error.noMigrationPath`
    /// * `Migration.Error.unidentifiedSource`
    convenience init(model: Model, persisted: Bool = true) throws {
        let storeURL = FileManager.default.storeURL
        
        // Attempt Migration (if required / if persisted)
        if persisted {
            do {
                if let source = try Migration.migrateStore(at: storeURL, to: model) {
                    InternalLog.coreData.info("Successful Migration from \(source.rawValue) to \(model.rawValue)")
                }
            } catch let error as Migration.Error {
                switch error {
                case .noMigrationPath, .unidentifiedSource:
                    InternalLog.coreData.error("Migration failed due to unrecoverable errors.", error: error)
                    if FileManager.default.fileExists(atPath: storeURL.path) {
                        try FileManager.default.removeItem(at: storeURL)
                    }
                default:
                    throw error
                }
            }
        }
        
        let objectModel = NSManagedObjectModel.make(for: model)
        
        self.init(name: FileManager.containerName, managedObjectModel: objectModel)
        
        let description = NSPersistentStoreDescription()
        if persisted {
            description.type = NSSQLiteStoreType
            description.url = storeURL
        } else {
            description.type = NSInMemoryStoreType
        }
        description.shouldInferMappingModelAutomatically = false
        description.shouldMigrateStoreAutomatically = false
        
        var loadError: Error? = nil
        
        persistentStoreDescriptions = [description]
        loadPersistentStores { (_, error) in
            loadError = error
        }
        
        if let error = loadError {
            throw error
        }
        
        viewContext.automaticallyMergesChangesFromParent = true
        viewContext.mergePolicy = NSMergePolicy(merge: .mergeByPropertyObjectTrumpMergePolicyType)
        viewContext.undoManager = nil
    }
    
    /// Removed all stores from the `persistentStoreCoordinator`/
    ///
    /// *WARNING*: The container & related context will be un-usable until a store has been reloaded.
    public func unload() {
        for store in persistentStoreCoordinator.persistentStores {
            do {
                try persistentStoreCoordinator.remove(store)
            } catch {
                InternalLog.coreData.error("Failed to remove persistent store from the store coordinator.", error: error)
            }
        }
    }
}
#endif
