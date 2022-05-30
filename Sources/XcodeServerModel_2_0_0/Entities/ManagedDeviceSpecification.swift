import Foundation
import CoreDataPlus
import XcodeServer
#if canImport(CoreData)
import CoreData

public class ManagedDeviceSpecification: NSManagedObject {

}

extension ManagedDeviceSpecification {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedDeviceSpecification> {
        return NSFetchRequest<ManagedDeviceSpecification>(entityName: "ManagedDeviceSpecification")
    }

    @NSManaged public var configuration: ManagedConfiguration?
    @NSManaged public var devices: NSSet?
    @NSManaged public var filters: NSSet?

}

// MARK: Generated accessors for devices
extension ManagedDeviceSpecification {

    @objc(addDevicesObject:)
    @NSManaged public func addToDevices(_ value: ManagedDevice)

    @objc(removeDevicesObject:)
    @NSManaged public func removeFromDevices(_ value: ManagedDevice)

    @objc(addDevices:)
    @NSManaged public func addToDevices(_ values: NSSet)

    @objc(removeDevices:)
    @NSManaged public func removeFromDevices(_ values: NSSet)

}

// MARK: Generated accessors for filters
extension ManagedDeviceSpecification {

    @objc(addFiltersObject:)
    @NSManaged public func addToFilters(_ value: ManagedFilter)

    @objc(removeFiltersObject:)
    @NSManaged public func removeFromFilters(_ value: ManagedFilter)

    @objc(addFilters:)
    @NSManaged public func addToFilters(_ values: NSSet)

    @objc(removeFilters:)
    @NSManaged public func removeFromFilters(_ values: NSSet)

}

extension ManagedDeviceSpecification {
    func update(_ specification: Device.Specification, context: NSManagedObjectContext) {
        (filters as? Set<ManagedFilter>)?.forEach({ context.delete($0) })
        
        specification.filters.forEach { (filter) in
            PersistentContainer.logger.info("Creating FILTER for DeviceSpecification")
            let _filter: ManagedFilter = context.make()
            _filter.update(filter, context: context)
            addToFilters(_filter)
        }
        
        (devices as? Set<ManagedDevice>)?.forEach({ context.delete($0) })
        
        specification.devices.forEach { (device) in
            // We only have access to the device id here.
            if let entity = ManagedDevice.device(device.id, in: context) {
                addToDevices(entity)
            } else {
                PersistentContainer.logger.info("Creating DEVICE for DeviceSpecification")
                let _device: ManagedDevice = context.make()
                _device.update(device, context: context)
                addToDevices(_device)
            }
        }
    }
}

extension Device.Specification {
    init(_ specification: ManagedDeviceSpecification) {
        self.init()
        if let filters = specification.filters as? Set<ManagedFilter> {
            self.filters = filters.map { Device.Filter($0) }
        }
        if let identifiers = specification.devices as? Set<ManagedDevice> {
            devices = Set(identifiers.map { Device($0) })
        }
    }
}
#endif
