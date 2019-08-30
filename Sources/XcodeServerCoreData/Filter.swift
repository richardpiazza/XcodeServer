import Foundation
import CoreData

public class Filter: NSManagedObject {
    
    public convenience init?(managedObjectContext: NSManagedObjectContext, deviceSpecification: DeviceSpecification) {
        self.init(managedObjectContext: managedObjectContext)
        self.deviceSpecification = deviceSpecification
    }
}
