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
                InternalLog.persistence.error("Failed to remove persistent store from the store coordinator.", error: error)
            }
        }
    }
}

public extension CoreDataContainer {
    static func managedObjectModel(forResource resource: String = .containerName, inBundle bundle: Bundle) -> NSManagedObjectModel {
        let url: URL
        
        if let _url = bundle.url(forResource: resource, withExtension: .momd) {
            url = _url
        } else if let _url = bundle.url(forResource: resource, withExtension: "\(String.momd)\(String.precompiled)") {
            url = _url
        } else {
            preconditionFailure("No URL for Resource '\(resource)' in Bundle '\(bundle.bundlePath)'.")
        }
        
        guard let model = NSManagedObjectModel(contentsOf: url) else {
            preconditionFailure("Unable to load contents of NSManagedObjectModel at URL '\(url.path)'.")
        }
        
        return model
    }
    
    static func mappingModel(forResource resource: String = .mappingModel, inBundle bundle: Bundle) -> NSMappingModel {
        let url: URL
        
        if let _url = bundle.url(forResource: resource, withExtension: .cdm) {
            url = _url
        } else if let _url = bundle.url(forResource: resource, withExtension: "\(String.cdm)\(String.precompiled)") {
            url = _url
        } else {
            preconditionFailure("No URL for Resource '\(resource)' in Bundle '\(bundle.bundlePath)'.")
        }
        
        guard let mapping = NSMappingModel(contentsOf: url) else {
            preconditionFailure("Unable to load contents of NSMappingModel at URL '\(url.path)'.")
        }
        
        return mapping
    }
}

#endif
