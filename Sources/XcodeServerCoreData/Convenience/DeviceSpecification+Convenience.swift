import XcodeServer
#if canImport(CoreData)
import CoreData

public extension DeviceSpecification {
    func update(_ specification: XcodeServer.Device.Specification, context: NSManagedObjectContext) {
        (filters as? Set<XcodeServerCoreData.Filter>)?.forEach({ context.delete($0) })
        
        specification.filters.forEach { (filter) in
            InternalLog.coreData.debug("Creating FILTER for DeviceSpecification")
            let _filter: Filter = context.make()
            _filter.update(filter, context: context)
            addToFilters(_filter)
        }
        
        (devices as? Set<XcodeServerCoreData.Device>)?.forEach({ context.delete($0) })
        
        specification.devices.forEach { (device) in
            // We only have access to the device id here.
            if let entity = context.device(withIdentifier: device.id) {
                addToDevices(entity)
            } else {
                InternalLog.coreData.debug("Creating DEVICE for DeviceSpecification")
                let _device: Device = context.make()
                _device.update(device, context: context)
                addToDevices(_device)
            }
        }
    }
}
#endif
