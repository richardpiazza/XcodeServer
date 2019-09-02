import Foundation
import CoreData
import XcodeServerCommon

@objc(Commit)
public class Commit: NSManagedObject {
    
    public convenience init?(managedObjectContext: NSManagedObjectContext, identifier: String, repository: Repository) {
        self.init(managedObjectContext: managedObjectContext)
        self.commitHash = identifier
        self.repository = repository
    }
    
}

// MARK: - CoreData Properties
public extension Commit {
    
    @NSManaged var commitHash: String
    @NSManaged var message: String?
    @NSManaged var timestamp: String?
    @NSManaged var commitChanges: Set<CommitChange>?
    @NSManaged var commitContributor: CommitContributor?
    @NSManaged var repository: Repository?
    @NSManaged var revisionBlueprints: Set<RevisionBlueprint>?
    
}

public extension Commit {
    var commitTimestamp: Date? {
        guard let timestamp = self.timestamp else {
            return nil
        }
        
        return JSON.dateFormatter.date(from: timestamp)
    }
}
