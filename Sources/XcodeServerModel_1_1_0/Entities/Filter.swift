import XcodeServer
import XcodeServerCoreData
import Foundation
#if canImport(CoreData)
import CoreData

//@objc(Filter)
class Filter: NSManagedObject {

}

extension Filter {

    @nonobjc class func fetchRequest() -> NSFetchRequest<Filter> {
        return NSFetchRequest<Filter>(entityName: "Filter")
    }

    @NSManaged var architectureTypeRawValue: Int16
    @NSManaged var filterTypeRawValue: Int16
    @NSManaged var deviceSpecification: DeviceSpecification?
    @NSManaged var platform: Platform?

}

extension Filter {
    func update(_ filter: XcodeServer.Device.Filter, context: NSManagedObjectContext) {
        if platform == nil {
            InternalLog.coreData.debug("Creating PLATFORM for Filter")
            platform = context.make()
        }
        
        filterTypeRawValue = Int16(filter.type)
        architectureTypeRawValue = Int16(filter.architecture)
        platform?.update(filter.platform, context: context)
    }
}

extension XcodeServer.Device.Filter {
    init(_ filter: Filter) {
        self.init()
        if let platform = filter.platform {
            self.platform = XcodeServer.Device.Platform(platform)
        }
        type = Int(filter.filterTypeRawValue)
        architecture = Int(filter.architectureTypeRawValue)
    }
}

internal func == (lhs: Filter, rhs: XcodeServer.Device.Filter) -> Bool {
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
