import Foundation
#if canImport(CoreData)
import CoreData

@objc(Filter)
public class Filter: NSManagedObject {

}

extension Filter {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Filter> {
        return NSFetchRequest<Filter>(entityName: "Filter")
    }

    @NSManaged public var architectureTypeRawValue: Int16
    @NSManaged public var filterTypeRawValue: Int16
    @NSManaged public var deviceSpecification: DeviceSpecification?
    @NSManaged public var platform: Platform?

}
#endif
