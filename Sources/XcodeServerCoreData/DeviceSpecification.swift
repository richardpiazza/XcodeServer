import Foundation
#if canImport(CoreData)
import CoreData

@objc(DeviceSpecification)
public class DeviceSpecification: NSManagedObject {
    
    public convenience init?(managedObjectContext: NSManagedObjectContext, configuration: Configuration) {
        self.init(managedObjectContext: managedObjectContext)
        self.configuration = configuration
    }
}

// MARK: - CoreData Properties
public extension DeviceSpecification {
    
    @NSManaged var configuration: Configuration?
    @NSManaged var filters: Set<Filter>?
    @NSManaged var devices: Set<Device>?
    
}

#endif
