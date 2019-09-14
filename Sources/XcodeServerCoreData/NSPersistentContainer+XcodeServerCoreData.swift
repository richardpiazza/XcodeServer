import Foundation
#if canImport(CoreData)
import CoreData

public extension NSPersistentContainer {
    
    static var xcodeServerCoreData: NSPersistentContainer = {
        let model = Model_1_0_0()
        
        let storeURL = FileManager.default.storeURL
        
        let description = NSPersistentStoreDescription(url: storeURL)
        description.shouldInferMappingModelAutomatically = false
        description.shouldMigrateStoreAutomatically = false
        
        let container = NSPersistentContainer(name: "XcodeServer", managedObjectModel: model)
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (_, error) in
            if let e = error {
                fatalError(e.localizedDescription)
            }
            
            container.viewContext.automaticallyMergesChangesFromParent = true
            container.viewContext.mergePolicy = NSMergePolicy(merge: .mergeByPropertyObjectTrumpMergePolicyType)
        }
        
        return container
    }()
    
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
            root = try url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            #elseif os(watchOS)
            root = try url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            #elseif os(macOS)
            root = try url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            #elseif os(UIKitForMac)
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
