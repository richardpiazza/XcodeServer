import XcodeServer
import CoreDataPlus
import Foundation
#if canImport(CoreData)
import CoreData

//@objc(DeviceSpecification)
class DeviceSpecification: NSManagedObject {

}

extension DeviceSpecification {

    @nonobjc class func fetchRequest() -> NSFetchRequest<DeviceSpecification> {
        return NSFetchRequest<DeviceSpecification>(entityName: "DeviceSpecification")
    }

    @NSManaged var configuration: Configuration?
    @NSManaged var devices: NSSet?
    @NSManaged var filters: NSSet?

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

extension DeviceSpecification {
    func update(_ specification: XcodeServer.Device.Specification, context: NSManagedObjectContext) {
        (filters as? Set<Filter>)?.forEach({ context.delete($0) })
        
        specification.filters.forEach { (filter) in
            InternalLog.persistence.debug("Creating FILTER for DeviceSpecification")
            let _filter: Filter = context.make()
            _filter.update(filter, context: context)
            addToFilters(_filter)
        }
        
        (devices as? Set<Device>)?.forEach({ context.delete($0) })
        
        specification.devices.forEach { (device) in
            // We only have access to the device id here.
            if let entity = Device.device(device.id, in: context) {
                addToDevices(entity)
            } else {
                InternalLog.persistence.debug("Creating DEVICE for DeviceSpecification")
                let _device: Device = context.make()
                _device.update(device, context: context)
                addToDevices(_device)
            }
        }
    }
}

extension XcodeServer.Device.Specification {
    init(_ specification: DeviceSpecification) {
        self.init()
        if let filters = specification.filters as? Set<Filter> {
            self.filters = filters.map { XcodeServer.Device.Filter($0) }
        }
        if let identifiers = specification.devices as? Set<Device> {
            devices = Set(identifiers.map { XcodeServer.Device($0) })
        }
    }
}

#endif
