import Foundation
#if canImport(CoreData)
import CoreData

@objc(Commit)
public class Commit: NSManagedObject {

}


extension Commit {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Commit> {
        return NSFetchRequest<Commit>(entityName: "Commit")
    }

    @NSManaged public var commitHash: String?
    @NSManaged public var date: Date?
    @NSManaged public var message: String?
    @NSManaged public var commitChanges: NSSet?
    @NSManaged public var commitContributor: CommitContributor?
    @NSManaged public var repository: Repository?
    @NSManaged public var revisionBlueprints: NSSet?

}

// MARK: Generated accessors for commitChanges
extension Commit {

    @objc(addCommitChangesObject:)
    @NSManaged public func addToCommitChanges(_ value: CommitChange)

    @objc(removeCommitChangesObject:)
    @NSManaged public func removeFromCommitChanges(_ value: CommitChange)

    @objc(addCommitChanges:)
    @NSManaged public func addToCommitChanges(_ values: NSSet)

    @objc(removeCommitChanges:)
    @NSManaged public func removeFromCommitChanges(_ values: NSSet)

}

// MARK: Generated accessors for revisionBlueprints
extension Commit {

    @objc(addRevisionBlueprintsObject:)
    @NSManaged public func addToRevisionBlueprints(_ value: RevisionBlueprint)

    @objc(removeRevisionBlueprintsObject:)
    @NSManaged public func removeFromRevisionBlueprints(_ value: RevisionBlueprint)

    @objc(addRevisionBlueprints:)
    @NSManaged public func addToRevisionBlueprints(_ values: NSSet)

    @objc(removeRevisionBlueprints:)
    @NSManaged public func removeFromRevisionBlueprints(_ values: NSSet)

}
#endif
