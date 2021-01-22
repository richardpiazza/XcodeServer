import XcodeServer
import CoreDataPlus
import Foundation
#if canImport(CoreData)
import CoreData

//@objc(Platform)
class Platform: NSManagedObject {

}

extension Platform {

    @nonobjc class func fetchRequest() -> NSFetchRequest<Platform> {
        return NSFetchRequest<Platform>(entityName: "Platform")
    }

    @NSManaged var buildNumber: String?
    @NSManaged var displayName: String?
    @NSManaged var identifier: String?
    @NSManaged var platformIdentifier: String?
    @NSManaged var simulatorIdentifier: String?
    @NSManaged var version: String?
    @NSManaged var filter: Filter?

}

extension Platform {
    func update(_ platform: XcodeServer.Device.Platform, context: NSManagedObjectContext) {
        buildNumber = platform.buildNumber
        displayName = platform.displayName
        identifier = platform.id
        platformIdentifier = platform.platformIdentifier
        simulatorIdentifier = platform.simulatorIdentifier
        version = platform.version
    }
}

extension XcodeServer.Device.Platform {
    init(_ platform: Platform) {
        self.init(id: platform.identifier ?? "")
        buildNumber = platform.buildNumber ?? ""
        displayName = platform.displayName ?? ""
        platformIdentifier = platform.platformIdentifier ?? ""
        simulatorIdentifier = platform.simulatorIdentifier ?? ""
        version = platform.version ?? ""
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
#endif
