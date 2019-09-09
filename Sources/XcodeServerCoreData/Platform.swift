import Foundation
import CoreData

@objc(Platform)
public class Platform: NSManagedObject {
    
    public convenience init?(managedObjectContext: NSManagedObjectContext, identifier: UUID, filter: Filter) {
        self.init(managedObjectContext: managedObjectContext)
        self.identifier = identifier
        self.filter = filter
    }
}

// MARK: - CoreData Properties
public extension Platform {
    
    @NSManaged var buildNumber: String?
    @NSManaged var displayName: String?
    @NSManaged var identifier: UUID?
    @NSManaged var platformIdentifier: String?
    @NSManaged var simulatorIdentifier: UUID?
    @NSManaged var version: String?
    @NSManaged var filter: Filter?
    
}
