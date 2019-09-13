import Foundation
#if canImport(CoreData)
import CoreData

@objc(Filter)
public class Filter: NSManagedObject {
    
    public convenience init?(managedObjectContext: NSManagedObjectContext, deviceSpecification: DeviceSpecification) {
        self.init(managedObjectContext: managedObjectContext)
        self.deviceSpecification = deviceSpecification
        self.architectureTypeRawValue = 0
        self.filterTypeRawValue = 0
    }
}

// MARK: - CoreData Properties
public extension Filter {
    
    @NSManaged var architectureTypeRawValue: Int16
    @NSManaged var deviceSpecification: DeviceSpecification?
    @NSManaged var filterTypeRawValue: Int16
    @NSManaged var platform: Platform?
    
}

#endif
