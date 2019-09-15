import Foundation
import XcodeServerAPI
#if canImport(CoreData)
import XcodeServerCoreData

extension Platform {
    public func update(withPlatform platform: XCSPlatform) {
        self.displayName = platform.displayName
        self.simulatorIdentifier = platform.simulatorIdentifier
        self.platformIdentifier = platform.platformIdentifier
        self.buildNumber = platform.buildNumber
        self.version = platform.version
    }
}

#endif
