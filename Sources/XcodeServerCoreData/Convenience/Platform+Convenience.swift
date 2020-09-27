import XcodeServer
#if canImport(CoreData)
import CoreData

public extension Platform {
    func update(_ platform: XcodeServer.Device.Platform, context: NSManagedObjectContext) {
        buildNumber = platform.buildNumber
        displayName = platform.displayName
        identifier = platform.id
        platformIdentifier = platform.platformIdentifier
        simulatorIdentifier = platform.simulatorIdentifier
        version = platform.version
    }
}

internal func == (_ lhs: Platform, _ rhs: XcodeServer.Device.Platform) -> Bool {
    guard lhs.identifier == rhs.id else {
        return false
    }
    guard lhs.buildNumber == rhs.buildNumber else {
        return false
    }
    guard lhs.displayName == rhs.displayName else {
        return false
    }
    guard lhs.platformIdentifier == rhs.platformIdentifier else {
        return false
    }
    guard lhs.simulatorIdentifier == rhs.simulatorIdentifier else {
        return false
    }
    guard lhs.version == rhs.version else {
        return false
    }
    return true
}

/*
 extension XcodeServerCoreData.Platform {
     public func update(withPlatform platform: XCSPlatform) {
         self.displayName = platform.displayName
         self.simulatorIdentifier = platform.simulatorIdentifier
         self.platformIdentifier = platform.platformIdentifier
         self.buildNumber = platform.buildNumber
         self.version = platform.version
     }
 }
 */

#endif
