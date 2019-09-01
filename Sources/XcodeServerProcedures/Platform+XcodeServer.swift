import Foundation
import XcodeServerAPI
import XcodeServerCoreData

extension Platform {
    public func update(withPlatform platform: XCSPlatform) {
        self.identifier = platform._id
        self.revision = platform._rev
        self.displayName = platform.displayName
        self.simulatorIdentifier = platform.simulatorIdentifier
        self.platformIdentifier = platform.identifier
        self.buildNumber = platform.buildNumber
        self.version = platform.version
    }
}
