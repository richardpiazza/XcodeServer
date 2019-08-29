import Foundation
import CoreData
import XcodeServerAPI

public class Filter: NSManagedObject {
    
    public convenience init?(managedObjectContext: NSManagedObjectContext, deviceSpecification: DeviceSpecification) {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "Filter", in: managedObjectContext) else {
            return nil
        }
        
        self.init(entity: entityDescription, insertInto: managedObjectContext)
        self.deviceSpecification = deviceSpecification
    }
    
    public func update(withFilter filter: XCSFilter) {
        guard let moc = self.managedObjectContext else {
            return
        }
        
        self.filterType = filter.filterType as NSNumber?
        self.architectureType = filter.architectureType as NSNumber?
        
        if let filterPlatform = filter.platform {
            if self.platform == nil {
                self.platform = Platform(managedObjectContext: moc, filter: self)
            }
            
            if let platform = self.platform {
                platform.update(withPlatform: filterPlatform)
            }
        }
    }
}
