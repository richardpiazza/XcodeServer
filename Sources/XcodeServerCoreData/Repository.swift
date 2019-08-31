import Foundation
import CoreData

@objc(Repository)
public class Repository: NSManagedObject {
    
    public convenience init?(managedObjectContext: NSManagedObjectContext, identifier: String) {
        self.init(managedObjectContext: managedObjectContext)
        self.identifier = identifier
    }
}

// MARK: - CoreData Properties
public extension Repository {
    
    @NSManaged var branchIdentifier: String?
    @NSManaged var branchOptions: NSNumber?
    @NSManaged var identifier: String
    @NSManaged var locationType: String?
    @NSManaged var system: String?
    @NSManaged var url: String?
    @NSManaged var workingCopyPath: String?
    @NSManaged var workingCopyState: NSNumber?
    @NSManaged var commits: Set<Commit>?
    @NSManaged var configurations: Set<Configuration>?
    
}
