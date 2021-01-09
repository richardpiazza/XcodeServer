import XcodeServer
import Foundation
#if canImport(CoreData)
import CoreData

public extension NSPersistentContainer {
    /// Initializes the `NSPersistentContainer` with a specified `Model` version.
    ///
    /// If an existing store exists at the default URL, a _heavyweight_ migration will be performed. If
    /// `silentMigrationFailure` is true, than any existing store will be removed if failure is due to:
    /// * `Migration.Error.noMigrationPath`
    /// * `Migration.Error.unidentifiedSource`
    ///
    /// - parameter model: The `Model` version with which to initialize the container.
    /// - parameter persisted: Controls the underlying store type. SQLite for persisted, In-Memory for not.
    /// - parameter silentMigrationFailure: When enabled, some migration errors will fall back to a clean state.
    convenience init(
        model: Model,
        persisted: Bool = true,
        silentMigrationFailure: Bool = true,
        assistant: ModelAssistant
    ) throws {
        let storeURL: URL = .storeURL
        
        // Attempt Migration (if required / if persisted)
        if persisted {
            do {
                if let source = try Migration.migrateStore(at: storeURL, to: model, assistant: assistant) {
                    InternalLog.coreData.info("Successful Migration from \(source.rawValue) to \(model.rawValue)")
                }
            } catch let error as Migration.Error {
                switch error {
                case .noMigrationPath, .unidentifiedSource:
                    if silentMigrationFailure {
                        InternalLog.coreData.error("Migration Failed, cleaning store.", error: error)
                        if FileManager.default.fileExists(atPath: storeURL.path) {
                            try FileManager.default.removeItem(at: storeURL)
                        }
                    } else {
                        InternalLog.coreData.error("Migration Failed", error: error)
                        throw error
                    }
                default:
                    InternalLog.coreData.error("Migration Failed", error: error)
                    throw error
                }
            } catch {
                InternalLog.coreData.error("Migration Failed", error: error)
                throw error
            }
        }
        
        let objectModel: NSManagedObjectModel = assistant.managedObjectModelFor(model)
        
        self.init(name: .containerName, managedObjectModel: objectModel)
        
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
}
#endif
