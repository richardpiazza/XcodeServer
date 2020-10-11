import XcodeServer
#if canImport(CoreData)
import CoreData

public extension DeviceSpecification {
    func update(_ specification: XcodeServer.Device.Specification, context: NSManagedObjectContext) {
        filters?.removeAll()
        specification.filters.forEach { (filter) in
            let _filter = Filter(context: context)
            _filter.update(filter, context: context)
            filters?.insert(_filter)
        }
        
        devices?.removeAll()
        specification.devices.forEach { (device) in
            // We only have access to the device id here.
            if let entity = context.device(withIdentifier: device.id) {
                devices?.insert(entity)
            } else {
                let _device = Device(context: context)
                _device.update(device, context: context)
                devices?.insert(_device)
            }
        }
    }
}
#endif
