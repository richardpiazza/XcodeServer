import Foundation
import CoreDataPlus
import XcodeServer
#if canImport(CoreData)
import CoreData

public class ManagedFilter: NSManagedObject {

}

extension ManagedFilter {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedFilter> {
        return NSFetchRequest<ManagedFilter>(entityName: "ManagedFilter")
    }

    @NSManaged public var architectureTypeRawValue: Int16
    @NSManaged public var filterTypeRawValue: Int16
    @NSManaged public var deviceSpecification: ManagedDeviceSpecification?
    @NSManaged public var platform: ManagedPlatform?

}

extension ManagedFilter {
    func update(_ filter: Device.Filter, context: NSManagedObjectContext) {
        if platform == nil {
            PersistentContainer.logger.info("Creating PLATFORM for Filter")
            platform = context.make()
        }
        
        filterTypeRawValue = Int16(filter.type)
        architectureTypeRawValue = Int16(filter.architecture)
        platform?.update(filter.platform, context: context)
    }
}

extension Device.Filter {
    init(_ filter: ManagedFilter) {
        self.init()
        if let platform = filter.platform {
            self.platform = Device.Platform(platform)
        }
        type = Int(filter.filterTypeRawValue)
        architecture = Int(filter.architectureTypeRawValue)
    }
}

internal func == (lhs: ManagedFilter, rhs: Device.Filter) -> Bool {
    guard Int(lhs.architectureTypeRawValue) == rhs.architecture else {
        return false
    }
    guard Int(lhs.filterTypeRawValue) == rhs.type else {
        return false
    }
    guard let p = lhs.platform, p == rhs.platform else {
        return false
    }
    return true
}
#endif
