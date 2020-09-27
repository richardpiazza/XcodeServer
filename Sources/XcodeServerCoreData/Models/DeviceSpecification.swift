import Foundation
#if canImport(CoreData)
import CoreData

@objc(DeviceSpecification)
public class DeviceSpecification: NSManagedObject {
    
    @NSManaged public var configuration: Configuration?
    @NSManaged public var filters: Set<Filter>?
    @NSManaged public var devices: Set<Device>?
    
}

#endif
