import Foundation
import XcodeServer
#if canImport(CoreData)
import CoreData
#endif

public enum Model {
    case v1_0_0
    
    #if canImport(CoreData)
    public var model: NSManagedObjectModel {
        switch self {
        case .v1_0_0: return Model_1_0_0.instance
        }
    }
    #endif
    
    /// API Version number reported by the Xcode Server API
    public var compatibleAPIVersions: [XcodeServer.Server.API] {
        switch self {
        case .v1_0_0:
            return [.v19]
        }
    }
    
    /// Xcode Server version information reported by the Xcode Server API
    public var compatibleXcodeServerVersions: [XcodeServer.Server.App] {
        switch self {
        case .v1_0_0:
            return [.v2_0]
        }
    }
}
