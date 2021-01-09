import XcodeServer
import XcodeServerCoreData
import Foundation
#if canImport(CoreData)
import CoreData

//@objc(Commit)
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

public extension Commit {
    /// Retrieves all `Commit` entities from the Core Data `NSManagedObjectContext`
    static func commits(in context: NSManagedObjectContext) -> [Commit] {
        let request = NSFetchRequest<Commit>(entityName: entityName)
        do {
            return try context.fetch(request)
        } catch {
            InternalLog.coreData.error("Failed to fetch commits", error: error)
        }
        
        return []
    }
    
    /// Retrieves the first `Commit` entity from the Core Data `NSManagedObjectContext` that matches the specified Hash
    /// identifier.
    static func commit(_ id: XcodeServer.SourceControl.Commit.ID, in context: NSManagedObjectContext) -> Commit? {
        let request = NSFetchRequest<Commit>(entityName: entityName)
        request.predicate = NSPredicate(format: "commitHash = %@", argumentArray: [id])
        do {
            return try context.fetch(request).first
        } catch {
            InternalLog.coreData.error("Failed to fetch commit '\(id)'", error: error)
        }
        
        return nil
    }
    
    static func incompleteCommits(id context: NSManagedObjectContext) -> [Commit] {
        let request = NSFetchRequest<Commit>(entityName: entityName)
        request.predicate = NSPredicate(format: "message == nil OR commitContributor == nil", argumentArray: nil)
        do {
            return try context.fetch(request)
        } catch {
            InternalLog.coreData.error("Failed to fetch incomplete commits", error: error)
        }
        
        return []
    }
}

public extension Commit {
    func update(_ commit: SourceControl.Commit, integration: Integration? = nil, context: NSManagedObjectContext) {
        if commitContributor == nil {
            InternalLog.coreData.debug("Creating COMMIT_CONTRIBUTOR for Commit [\(commit.id)]")
            commitContributor = context.make()
        }
        
        commitHash = commit.id
        message = commit.message
        date = commit.date
        commitContributor?.update(commit.contributor)
        
        (commitChanges as? Set<CommitChange>)?.forEach({ context.delete($0) })
        commit.changes.forEach { (change) in
            let _change: CommitChange = context.make()
            _change.update(change)
            addToCommitChanges(_change)
        }
        
        if let integration = integration {
            if RevisionBlueprint.revisionBlueprint(withCommit: self, andIntegration: integration, in: context) == nil {
                InternalLog.coreData.debug("Creating REVISION_BLUEPRINT for Commit [\(commit.id)] and Integration [\(integration.identifier ?? "")]")
                let blueprint: RevisionBlueprint = context.make()
                blueprint.commit = self
                blueprint.integration = integration
            }
        }
    }
}

public extension SourceControl.Commit {
    init(_ commit: Commit) {
        self.init(id: commit.commitHash ?? "")
        message = commit.message ?? ""
        date = commit.date ?? Date()
        if let contributor = commit.commitContributor {
            self.contributor = SourceControl.Contributor(contributor)
        }
        if let changes = commit.commitChanges as? Set<CommitChange> {
            self.changes = changes.map({ SourceControl.Change($0) })
        }
        if let blueprints = commit.revisionBlueprints as? Set<RevisionBlueprint>, !blueprints.isEmpty {
            integrationId = blueprints.first?.integration?.identifier
        }
        remoteId = commit.repository?.identifier
    }
}
#endif
