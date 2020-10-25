import Foundation
import XcodeServer

public enum Model {
    /// The base model available in the framework.
    case v1_0_0
    
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
