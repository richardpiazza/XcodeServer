import Foundation
import XcodeServerCommon
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
    
    public var compatibleAPIVersions: [APIVersion] {
        switch self {
        case .v1_0_0:
            return [.v19]
        }
    }
    
    public var compatibleMacOSVersions: [MacOSVersion] {
        switch self {
        case .v1_0_0:
            return [.v10_14_6, .v10_15]
        }
    }
    
    public var compatibleMacOSServerVersions: [MacOSServerVersion] {
        switch self {
        case .v1_0_0:
            return [.v5_7_1, .v5_8]
        }
    }
    
    public var compatibleXcodeVersions: [XcodeVersion] {
        switch self {
        case .v1_0_0:
            return [.v_10_3, .v_11_0]
        }
    }
    
    public var compatibleXcodeServerVersions: [XcodeServerVersion] {
        switch self {
        case .v1_0_0:
            return [.v_2_0]
        }
    }
}
