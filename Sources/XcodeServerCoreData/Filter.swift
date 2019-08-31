import Foundation
import CoreData

public class Filter: NSManagedObject {
    
    public convenience init?(managedObjectContext: NSManagedObjectContext, deviceSpecification: DeviceSpecification) {
        self.init(managedObjectContext: managedObjectContext)
        self.deviceSpecification = deviceSpecification
    }
}

// MARK: - CoreData Properties
public extension Filter {
    
    @NSManaged var architectureType: NSNumber?
    @NSManaged var filterType: NSNumber?
    @NSManaged var deviceSpecification: DeviceSpecification?
    @NSManaged var platform: Platform?
    
}
