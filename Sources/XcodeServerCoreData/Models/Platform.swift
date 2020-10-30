import Foundation
#if canImport(CoreData)
import CoreData

@objc(Platform)
public class Platform: NSManagedObject {
    
    @NSManaged public var buildNumber: String?
    @NSManaged public var displayName: String?
    @NSManaged public var identifier: String
    @NSManaged public var platformIdentifier: String?
    @NSManaged public var simulatorIdentifier: String?
    @NSManaged public var version: String?
    @NSManaged public var filter: Filter?
    
}

#endif
