import Foundation
import CoreData

@objc(CommitChange)
public class CommitChange: NSManagedObject {
    
    public convenience init?(managedObjectContext: NSManagedObjectContext, commit: Commit) {
        self.init(managedObjectContext: managedObjectContext)
        self.commit = commit
    }
}

// MARK: - CoreData Properties
public extension CommitChange {
    
    @NSManaged var filePath: String?
    @NSManaged var status: NSNumber?
    @NSManaged var commit: Commit?
    
}
