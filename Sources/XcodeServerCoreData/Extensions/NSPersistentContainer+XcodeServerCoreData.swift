import XcodeServer
import Foundation
#if canImport(CoreData)
import CoreData

extension NSPersistentContainer {
    convenience init(model: Model, persisted: Bool = true) {
        let objectModel = NSManagedObjectModel.make(for: model)
        self.init(model: objectModel, persisted: persisted)
    }
    
    convenience init(model: NSManagedObjectModel, persisted: Bool = true) {
        let name = "XcodeServer"
        let storeURL = FileManager.default.storeURL
        
        let description = NSPersistentStoreDescription()
        if persisted {
            description.type = NSSQLiteStoreType
            description.url = storeURL
        } else {
            description.type = NSInMemoryStoreType
        }
        description.shouldInferMappingModelAutomatically = false
        description.shouldMigrateStoreAutomatically = false
        
        if persisted {
            do {
                let metadata = try NSPersistentStoreCoordinator.metadataForPersistentStore(ofType: NSSQLiteStoreType, at: storeURL, options: nil)
                if !model.isConfiguration(withName: name, compatibleWithStoreMetadata: metadata) {
                    try FileManager.default.removeItem(at: storeURL)
                }
            } catch let error as NSError {
                if error.code == 260 {
                    // Expected (File Not Found)
                } else {
                    InternalLog.coreData.error("Failed to load store metadata or remove existing.", error: error)
                }
            }
        }
        
        // check for migration
        // perform if necessary
        
        self.init(name: name, managedObjectModel: model)
        
        persistentStoreDescriptions = [description]
        loadPersistentStores { (_, error) in
            if let e = error {
                fatalError(e.localizedDescription)
            }
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
