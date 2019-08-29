import Foundation
import CoreData
import XcodeServerAPI

public class DeviceSpecification: NSManagedObject {
    
    public convenience init?(managedObjectContext: NSManagedObjectContext, configuration: Configuration) {
        self.init(managedObjectContext: managedObjectContext)
        self.configuration = configuration
    }
    
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
                if let filter = Filter(managedObjectContext: moc, deviceSpecification: self) {
                    filter.update(withFilter: specificationFilter)
                }
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
