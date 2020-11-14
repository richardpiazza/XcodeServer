import Foundation
#if canImport(CoreData)
import CoreData

@objc(DeviceSpecification)
public class DeviceSpecification: NSManagedObject {

}

extension DeviceSpecification {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DeviceSpecification> {
        return NSFetchRequest<DeviceSpecification>(entityName: "DeviceSpecification")
    }

    @NSManaged public var configuration: Configuration?
    @NSManaged public var devices: NSSet?
    @NSManaged public var filters: NSSet?

}

// MARK: Generated accessors for devices
extension DeviceSpecification {

    @objc(addDevicesObject:)
    @NSManaged public func addToDevices(_ value: Device)

    @objc(removeDevicesObject:)
    @NSManaged public func removeFromDevices(_ value: Device)

    @objc(addDevices:)
    @NSManaged public func addToDevices(_ values: NSSet)

    @objc(removeDevices:)
    @NSManaged public func removeFromDevices(_ values: NSSet)

}

// MARK: Generated accessors for filters
extension DeviceSpecification {

    @objc(addFiltersObject:)
    @NSManaged public func addToFilters(_ value: Filter)

    @objc(removeFiltersObject:)
    @NSManaged public func removeFromFilters(_ value: Filter)

    @objc(addFilters:)
    @NSManaged public func addToFilters(_ values: NSSet)

    @objc(removeFilters:)
    @NSManaged public func removeFromFilters(_ values: NSSet)

}
#endif
