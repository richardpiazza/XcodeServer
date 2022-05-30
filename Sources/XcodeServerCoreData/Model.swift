import XcodeServer
import CoreDataPlus
import XcodeServerModel_1_0_0
import XcodeServerModel_1_1_0
import XcodeServerModel_2_0_0
#if canImport(CoreData)
import CoreData

public enum Model: String, Hashable, CaseIterable, ModelVersion, ModelCatalog {
    /// The base model available in the framework.
    case v1_0_0 = "1.0.0"
    /// Added `IntegrationIssues.triggerErrors`
    case v1_1_0 = "1.1.0"
    /// Prefixed entity names
    ///
    /// * All entities now use a 'Managed' prefix to distinguish between the persisted and non-persisted type.
    /// * Integration issues can be linked to more than one integration.
    case v2_0_0 = "2.0.0"
    
    /// The preferred/most current version of the model.
    public static var current: Model = .v2_0_0
    
    public static var allVersions: [Self] { allCases }
    
    public var managedObjectModel: NSManagedObjectModel {
        switch self {
        case .v1_0_0: return XcodeServerModel_1_0_0.PersistentContainer.managedObjectModel
        case .v1_1_0: return XcodeServerModel_1_1_0.PersistentContainer.managedObjectModel
        case .v2_0_0: return XcodeServerModel_2_0_0.PersistentContainer.managedObjectModel
        }
    }
    
    public var mappingModel: NSMappingModel? {
        switch self {
        case .v1_0_0: return nil
        case .v1_1_0: return XcodeServerModel_1_1_0.PersistentContainer.mappingModel
        case .v2_0_0: return XcodeServerModel_2_0_0.PersistentContainer.mappingModel
        }
    }
    
    public var previousVersion: ModelVersion? {
        switch self {
        case .v1_0_0: return nil
        case .v1_1_0: return Model.v1_0_0
        case .v2_0_0: return Model.v1_1_0
        }
    }
    
    /// API Version number reported by the Xcode Server API
    public var compatibleAPIVersions: [XcodeServer.Server.API] {
        switch self {
        case .v1_0_0, .v1_1_0, .v2_0_0:
            return [.v19]
        }
    }
    
    /// Xcode Server version information reported by the Xcode Server API
    public var compatibleXcodeServerVersions: [XcodeServer.Server.App] {
        switch self {
        case .v1_0_0, .v1_1_0, .v2_0_0:
            return [.v2_0]
        }
    }
}
#endif
