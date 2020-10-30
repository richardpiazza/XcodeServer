import Foundation
#if canImport(CoreData)
import CoreData

@objc(Filter)
public class Filter: NSManagedObject {
    
    @NSManaged public var architectureTypeRawValue: Int16
    @NSManaged public var deviceSpecification: DeviceSpecification?
    @NSManaged public var filterTypeRawValue: Int16
    @NSManaged public var platform: Platform?
    
}

#endif
