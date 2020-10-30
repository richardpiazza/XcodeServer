import XcodeServer

public enum Model: String, Hashable, CaseIterable {
    /// The base model available in the framework.
    case v1_0_0 = "1.0.0"
    
    /// The current version of the model selected in the `xcdatamodeld` resource.
    public static var current: Model = .v1_0_0
    
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
    
    public var nextVersion: Model? {
        switch self {
        case .v1_0_0:
            return nil
        }
    }
}
