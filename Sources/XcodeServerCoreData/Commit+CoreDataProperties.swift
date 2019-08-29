import Foundation
import CoreData

public extension Commit {

    @NSManaged var commitHash: String
    @NSManaged var message: String?
    @NSManaged var timestamp: String?
    @NSManaged var commitChanges: Set<CommitChange>?
    @NSManaged var commitContributor: CommitContributor?
    @NSManaged var repository: Repository?
    @NSManaged var revisionBlueprints: Set<RevisionBlueprint>?

}
