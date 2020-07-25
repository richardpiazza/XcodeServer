import Foundation
#if canImport(CoreData)
import CoreData

@objc(Repository)
public class Repository: NSManagedObject {
    
    public convenience init?(managedObjectContext: NSManagedObjectContext, identifier: String) {
        self.init(managedObjectContext: managedObjectContext)
        self.identifier = identifier
        self.branchOptions = 0
    }
}

// MARK: - CoreData Properties
public extension Repository {
    
    @NSManaged var branchIdentifier: String?
    @NSManaged var branchOptions: Int16
    @NSManaged var identifier: String
    @NSManaged var locationType: String?
    @NSManaged var system: String?
    @NSManaged var url: String?
    @NSManaged var workingCopyPath: String?
    @NSManaged var workingCopyState: NSNumber?
    @NSManaged var commits: Set<Commit>?
    @NSManaged var configurations: Set<Configuration>?
    
}

#endif
