import XcodeServer
import Foundation
#if canImport(CoreData)
import CoreData

public extension NSPersistentContainer {
    
    convenience init(model: Model, persisted: Bool = true) {
        let directoryURL = FileManager.default.xcodeServerDirectory
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
                try FileManager.default.createDirectory(at: directoryURL, withIntermediateDirectories: true, attributes: nil)
                let metadata = try NSPersistentStoreCoordinator.metadataForPersistentStore(ofType: NSSQLiteStoreType, at: storeURL, options: nil)
                if !Model.v1_0_0.model.isConfiguration(withName: "XcodeServer", compatibleWithStoreMetadata: metadata) {
                    try FileManager.default.removeItem(at: storeURL)
                }
            } catch {
                InternalLog.coreData.error("", error: error)
            }
        }
        
        // check for migration
        // perform if necessary
        
        self.init(name: "XcodeServer", managedObjectModel: model.model)
        
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
    func unload() {
        for store in persistentStoreCoordinator.persistentStores {
            do {
                try persistentStoreCoordinator.remove(store)
            } catch {
                InternalLog.coreData.error("", error: error)
            }
        }
    }
}

public extension FileManager {
    var storeURL: URL {
        let name = "XcodeServer.sqlite"
        return xcodeServerDirectory.appendingPathComponent(name)
    }
}

#endif
