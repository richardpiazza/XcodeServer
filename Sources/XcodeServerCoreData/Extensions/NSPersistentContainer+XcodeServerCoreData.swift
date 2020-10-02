import Foundation
#if canImport(CoreData)
import CoreData

public extension NSPersistentContainer {
    
    convenience init(model: Model, persisted: Bool = true) {
        let directoryURL = FileManager.default.directoryURL
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
                print(error)
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
            
            self.viewContext.automaticallyMergesChangesFromParent = true
            self.viewContext.mergePolicy = NSMergePolicy(merge: .mergeByPropertyObjectTrumpMergePolicyType)
        }
    }
    
    /// Removed all stores from the `persistentStoreCoordinator`/
    ///
    /// *WARNING*: The container & related context will be un-usable until a store has been reloaded.
    func unload() {
        for store in persistentStoreCoordinator.persistentStores {
            do {
                try persistentStoreCoordinator.remove(store)
            } catch {
                print(error)
            }
        }
    }
}

public extension FileManager {
    var directoryURL: URL {
        let folder = "XcodeServer"
        let root: URL
        do {
            #if os(tvOS)
            root = try url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            #else
            root = try url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            #endif
            
            return root.appendingPathComponent(folder, isDirectory: true)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    var storeURL: URL {
        let name = "XcodeServer.sqlite"
        return directoryURL.appendingPathComponent(name)
    }
}

#endif