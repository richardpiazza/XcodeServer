import Foundation
import CoreData
import XcodeServerAPI

public class CommitChange: NSManagedObject {
    
    public convenience init?(managedObjectContext: NSManagedObjectContext, commit: Commit) {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "CommitChange", in: managedObjectContext) else {
            return nil
        }
        
        self.init(entity: entityDescription, insertInto: managedObjectContext)
        self.commit = commit
    }
    
    public func update(withCommitChange change: XCSCommitChangeFilePath) {
        self.status = change.status as NSNumber?
        self.filePath = change.filePath
    }
}
