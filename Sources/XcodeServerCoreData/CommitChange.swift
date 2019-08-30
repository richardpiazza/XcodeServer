import Foundation
import CoreData

public class CommitChange: NSManagedObject {
    
    public convenience init?(managedObjectContext: NSManagedObjectContext, commit: Commit) {
        self.init(managedObjectContext: managedObjectContext)
        self.commit = commit
    }
}
