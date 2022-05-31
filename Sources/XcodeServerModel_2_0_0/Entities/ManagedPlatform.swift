import Foundation
import CoreDataPlus
import XcodeServer
#if canImport(CoreData)
import CoreData

public class ManagedPlatform: NSManagedObject {

}

extension ManagedPlatform {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedPlatform> {
        return NSFetchRequest<ManagedPlatform>(entityName: "ManagedPlatform")
    }

    @NSManaged public var buildNumber: String?
    @NSManaged public var displayName: String?
    @NSManaged public var identifier: String?
    @NSManaged public var platformIdentifier: String?
    @NSManaged public var simulatorIdentifier: String?
    @NSManaged public var version: String?
    @NSManaged public var filter: ManagedFilter?

}

extension ManagedPlatform {
    func update(_ platform: Device.Platform, context: NSManagedObjectContext) {
        buildNumber = platform.buildNumber
        displayName = platform.displayName
        identifier = platform.id
        platformIdentifier = platform.platformIdentifier
        simulatorIdentifier = platform.simulatorIdentifier
        version = platform.version
    }
}

extension Device.Platform {
    init(_ platform: ManagedPlatform) {
        self.init(id: platform.identifier ?? "")
        buildNumber = platform.buildNumber ?? ""
        displayName = platform.displayName ?? ""
        platformIdentifier = platform.platformIdentifier ?? ""
        simulatorIdentifier = platform.simulatorIdentifier ?? ""
        version = platform.version ?? ""
    }
}

internal func == (_ lhs: ManagedPlatform, _ rhs: Device.Platform) -> Bool {
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
