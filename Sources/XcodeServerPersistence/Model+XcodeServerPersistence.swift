import XcodeServer
import XcodeServerCoreData
import XcodeServerModel_1_0_0
import XcodeServerModel_1_1_0
#if canImport(CoreData)
import CoreData

public extension Model {
    var managedObjectModel: NSManagedObjectModel {
        switch self {
        case .v1_0_0: return XcodeServerModel_1_0_0.Container.managedObjectModel
        case .v1_1_0: return XcodeServerModel_1_1_0.Container.managedObjectModel
        }
    }
    
    var mappingModel: NSMappingModel? {
        switch self {
        case .v1_0_0: return nil
        case .v1_1_0: return XcodeServerModel_1_1_0.Container.mappingModel
        }
    }
}

#endif
