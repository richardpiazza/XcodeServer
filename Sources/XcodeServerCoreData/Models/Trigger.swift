import Foundation
#if canImport(CoreData)
import CoreData

@objc(Trigger)
public class Trigger: NSManagedObject {
    
    @NSManaged public var name: String?
    @NSManaged public var phaseRawValue: Int16
    @NSManaged public var scriptBody: String?
    @NSManaged public var typeRawValue: Int16
    @NSManaged public var conditions: Conditions?
    @NSManaged public var configuration: Configuration?
    @NSManaged public var emailConfiguration: EmailConfiguration?
    
}

#endif
