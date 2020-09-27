import Foundation
#if canImport(CoreData)
import CoreData

@objc(Commit)
public class Commit: NSManagedObject {
    
    @NSManaged public var commitHash: String
    @NSManaged public var message: String?
    @NSManaged public var date: Date?
    @NSManaged public var commitChanges: Set<CommitChange>?
    @NSManaged public var commitContributor: CommitContributor?
    @NSManaged public var repository: Repository?
    @NSManaged public var revisionBlueprints: Set<RevisionBlueprint>?
    
}

#endif
