import Foundation
import CoreData

public extension NSPersistentContainer {
    
    static var xcodeServerCoreData: NSPersistentContainer = {
        let model = Model_1_0_0()
        
        var storeURL: URL
        do {
            var searchPathDirectory: FileManager.SearchPathDirectory
            #if os(tvOS)
            searchPathDirectory = .cachesDirectory
            #else
            searchPathDirectory = .documentDirectory
            #endif
            storeURL = try FileManager.default.url(for: searchPathDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("XCServerCoreData.sqlite")
        } catch {
            print(error)
            fatalError(error.localizedDescription)
        }
        
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
    
}