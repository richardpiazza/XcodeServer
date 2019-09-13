import Foundation
import CoreData

@objc(Platform)
public class Platform: NSManagedObject {
    
    public convenience init?(managedObjectContext: NSManagedObjectContext, identifier: String, filter: Filter) {
        self.init(managedObjectContext: managedObjectContext)
        self.identifier = identifier
        self.filter = filter
    }
}

// MARK: - CoreData Properties
public extension Platform {
    
    @NSManaged var buildNumber: String?
    @NSManaged var displayName: String?
    @NSManaged var identifier: String
    @NSManaged var platformIdentifier: String?
    @NSManaged var simulatorIdentifier: UUID?
    @NSManaged var version: String?
    @NSManaged var filter: Filter?
    
}
