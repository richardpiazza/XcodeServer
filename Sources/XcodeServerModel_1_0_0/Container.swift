import XcodeServer
import XcodeServerCoreData
import Dispatch
#if canImport(CoreData)
import CoreData

public class Container: CoreDataContainer {
    
    public let persistentContainer: NSPersistentContainer
    internal let internalQueue: DispatchQueue = .init(label: "XcodeServer.XcodeServerModel_1_0_0.OperationQueue")
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
    
    public static var model: Model { .v1_0_0 }
    
    public static var managedObjectModel: NSManagedObjectModel = {
        Container.managedObjectModel(inBundle: .module)
    }()
    
    public static var mappingModel: NSMappingModel? { nil }
}
#endif