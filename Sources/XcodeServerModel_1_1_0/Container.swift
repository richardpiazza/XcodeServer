import XcodeServer
import XcodeServerCoreData
import Dispatch
#if canImport(CoreData)
import CoreData

public class Container: CoreDataContainer {
    
    public let persistentContainer: NSPersistentContainer
    internal let internalQueue: DispatchQueue = .init(label: "XcodeServer.XcodeServerModel_1_1_0.OperationQueue")
    internal let dispatchQueue: DispatchQueue
    
    /// Initializes Storage Container.
    ///
    /// - parameter queue: DispatchQueue on which all results will be returned (when not specified).
    /// - parameter persisted: When false, this store will only be maintained in memory.
    /// - parameter silentFailure: When enabled, some migration errors will fall back to a clean state.
    public init(
        queue: DispatchQueue = .main,
        persisted: Bool = true,
        silentFailure: Bool = true,
        assistant: ModelAssistant
    ) throws {
        persistentContainer = try NSPersistentContainer(model: Self.model, persisted: persisted, silentMigrationFailure: silentFailure, assistant: assistant)
        dispatchQueue = queue
    }
    
    public static var model: Model { .v1_1_0 }
    
    public static var managedObjectModel: NSManagedObjectModel = {
        guard let url = Bundle.module.url(forResource: .containerName, withExtension: .momd) else {
            preconditionFailure("No URL for Resource '\(String.containerName).\(String.momd)' in Bundle '\(Bundle.module.bundlePath)'.")
        }
        
        guard let model = NSManagedObjectModel(contentsOf: url) else {
            preconditionFailure("Unable to load contents of NSManagedObjectModel at URL '\(url.path)'.")
        }
        
        return model
    }()
    
    public static var mappingModel: NSMappingModel? {
        guard let url = Bundle.module.url(forResource: .mappingModel, withExtension: .cdm) else {
            preconditionFailure("No URL for Resource '\(String.mappingModel).\(String.cdm)' in Bundle '\(Bundle.module.bundlePath)'.")
        }
        
        guard let mapping = NSMappingModel(contentsOf: url) else {
            preconditionFailure("Unable to load contents of NSMappingModel at URL '\(url.path)'.")
        }
        
        return mapping
    }
    
    public static var modulePrefix: String {
        return Bundle.module.bundleURL.lastPathComponent.replacingOccurrences(of: ".bundle", with: "")
    }
}
#endif
