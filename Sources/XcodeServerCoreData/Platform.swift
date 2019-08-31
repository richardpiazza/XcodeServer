import Foundation
import CoreData

@objc(Platform)
public class Platform: NSManagedObject {
    
    public convenience init?(managedObjectContext: NSManagedObjectContext, filter: Filter) {
        self.init(managedObjectContext: managedObjectContext)
        self.filter = filter
    }
}

// MARK: - CoreData Properties
public extension Platform {
    
    @NSManaged var buildNumber: String?
    @NSManaged var displayName: String?
    @NSManaged var identifier: String?
    @NSManaged var platformIdentifier: String?
    @NSManaged var revision: String?
    @NSManaged var simulatorIdentifier: String?
    @NSManaged var version: String?
    @NSManaged var filter: Filter?
    
}
