import Foundation
import XcodeServerCommon
#if canImport(CoreData)
import CoreData

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
    
    @nonobjc class func fetchRequest() -> NSFetchRequest<Commit> {
        return NSFetchRequest<Commit>(entityName: entityName)
    }
    
    @NSManaged var commitHash: String
    @NSManaged var message: String?
    @NSManaged var date: Date?
    @NSManaged var commitChanges: Set<CommitChange>?
    @NSManaged var commitContributor: CommitContributor?
    @NSManaged var repository: Repository?
    @NSManaged var revisionBlueprints: Set<RevisionBlueprint>?
    
}

#endif
