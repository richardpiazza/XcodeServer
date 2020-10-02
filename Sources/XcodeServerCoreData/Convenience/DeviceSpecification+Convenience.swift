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

/*
 extension XcodeServerCoreData.DeviceSpecification {
     public func update(withDeviceSpecification specification: XCSDeviceSpecification) {
         guard let moc = self.managedObjectContext else {
             return
         }
         
         if let specificationFilters = specification.filters {
             if let filters = self.filters {
                 for filter in filters {
                     filter.deviceSpecification = nil
                     moc.delete(filter)
                 }
             }
             
             for specificationFilter in specificationFilters {
                 let new = Filter(context: moc)
                 new.deviceSpecification = self
                 new.update(withFilter: specificationFilter)
             }
         }
         
         if let specificationDeviceIdentifiers = specification.deviceIdentifiers {
             if let devices = self.devices {
                 for device in devices {
                     device.deviceSpecifications?.insert(self)
                 }
             }
             
             for specificationDeviceIdentifier in specificationDeviceIdentifiers {
                 if let device = moc.device(withIdentifier: specificationDeviceIdentifier) {
                     device.deviceSpecifications?.insert(self)
                     continue
                 }
                 
                 if let device = Device(managedObjectContext: moc) {
                     device.identifier = specificationDeviceIdentifier
                     device.deviceSpecifications?.insert(self)
                 }
             }
         }
     }
 }
 */

#endif
