import Foundation
#if canImport(CoreData)
import CoreData

public extension NSPersistentContainer {
    
    convenience init(model: Model) {
        let storeURL = FileManager.default.storeURL
        
        let description = NSPersistentStoreDescription(url: storeURL)
        description.shouldInferMappingModelAutomatically = false
        description.shouldMigrateStoreAutomatically = false
        
        do {
            let metadata = try NSPersistentStoreCoordinator.metadataForPersistentStore(ofType: NSSQLiteStoreType, at: storeURL, options: nil)
            if !Model.v1_0_0.model.isConfiguration(withName: "XcodeServer", compatibleWithStoreMetadata: metadata) {
                try FileManager.default.removeItem(at: storeURL)
            }
        } catch {
            print(error)
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

fileprivate extension FileManager {
    var storeURL: URL {
        let folder = "XcodeServer"
        let name = "XcodeServer.sqlite"
        
        let root: URL
        
        do {
            #if os(iOS)
            root = try url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            #elseif os(tvOS)
            root = try url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            #elseif os(watchOS)
            root = try url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            #elseif os(macOS)
            root = try url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            #elseif targetEnvironment(macCatalyst)
            root = try url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            #else
            root = try url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            #endif
            
            return root.appendingPathComponent(folder, isDirectory: true).appendingPathComponent(name)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}

#endif
