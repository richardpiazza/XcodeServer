import Foundation
import CoreData

public extension NSPersistentContainer {
    
    static var legacyXcodeServerCoreData: NSPersistentContainer = {
        let model = Model_2_0_3.instance
        
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
        description.shouldInferMappingModelAutomatically = true
        description.shouldMigrateStoreAutomatically = true
        
        let container = NSPersistentContainer(name: "XCServerCoreData", managedObjectModel: model)
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
