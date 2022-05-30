import Foundation
import CoreDataPlus
import XcodeServer
#if canImport(CoreData)
import CoreData

public class ManagedCommit: NSManagedObject {

}

extension ManagedCommit {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedCommit> {
        return NSFetchRequest<ManagedCommit>(entityName: "ManagedCommit")
    }

    @NSManaged public var commitHash: String?
    @NSManaged public var date: Date?
    @NSManaged public var message: String?
    @NSManaged public var commitChanges: NSSet?
    @NSManaged public var commitContributor: ManagedCommitContributor?
    @NSManaged public var repository: ManagedRepository?
    @NSManaged public var revisionBlueprints: NSSet?

}

// MARK: Generated accessors for commitChanges
extension ManagedCommit {

    @objc(addCommitChangesObject:)
    @NSManaged public func addToCommitChanges(_ value: ManagedCommitChange)

    @objc(removeCommitChangesObject:)
    @NSManaged public func removeFromCommitChanges(_ value: ManagedCommitChange)

    @objc(addCommitChanges:)
    @NSManaged public func addToCommitChanges(_ values: NSSet)

    @objc(removeCommitChanges:)
    @NSManaged public func removeFromCommitChanges(_ values: NSSet)

}

// MARK: Generated accessors for revisionBlueprints
extension ManagedCommit {

    @objc(addRevisionBlueprintsObject:)
    @NSManaged public func addToRevisionBlueprints(_ value: ManagedRevisionBlueprint)

    @objc(removeRevisionBlueprintsObject:)
    @NSManaged public func removeFromRevisionBlueprints(_ value: ManagedRevisionBlueprint)

    @objc(addRevisionBlueprints:)
    @NSManaged public func addToRevisionBlueprints(_ values: NSSet)

    @objc(removeRevisionBlueprints:)
    @NSManaged public func removeFromRevisionBlueprints(_ values: NSSet)

}

extension ManagedCommit {
    /// Retrieves all `Commit` entities from the Core Data `NSManagedObjectContext`
    static func commits(in context: NSManagedObjectContext) -> [ManagedCommit] {
        let request = NSFetchRequest<ManagedCommit>(entityName: entityName)
        do {
            return try context.fetch(request)
        } catch {
            PersistentContainer.logger.error("Failed to fetch commits", metadata: ["localizedDescription": .string(error.localizedDescription)])
        }
        
        return []
    }
    
    /// Retrieves the first `ManagedCommit` entity from the Core Data `NSManagedObjectContext` that matches the specified Hash identifier.
    static func commit(_ id: SourceControl.Commit.ID, in context: NSManagedObjectContext) -> ManagedCommit? {
        let request = NSFetchRequest<ManagedCommit>(entityName: entityName)
        request.predicate = NSPredicate(format: "commitHash = %@", argumentArray: [id])
        do {
            return try context.fetch(request).first
        } catch {
            PersistentContainer.logger.error("Failed to fetch commit '\(id)'", metadata: ["localizedDescription": .string(error.localizedDescription)])
        }
        
        return nil
    }
    
    static func incompleteCommits(in context: NSManagedObjectContext) -> [ManagedCommit] {
        let request = NSFetchRequest<ManagedCommit>(entityName: entityName)
        request.predicate = NSPredicate(format: "message == nil OR commitContributor == nil", argumentArray: nil)
        do {
            return try context.fetch(request)
        } catch {
            PersistentContainer.logger.error("Failed to fetch incomplete commits", metadata: ["localizedDescription": .string(error.localizedDescription)])
        }
        
        return []
    }
}

extension ManagedCommit {
    func update(_ commit: SourceControl.Commit, integration: ManagedIntegration? = nil, context: NSManagedObjectContext) {
        if commitContributor == nil {
            PersistentContainer.logger.info("Creating COMMIT_CONTRIBUTOR for Commit [\(commit.id)]")
            commitContributor = context.make()
        }
        
        commitHash = commit.id
        message = commit.message
        date = commit.date
        commitContributor?.update(commit.contributor)
        
        (commitChanges as? Set<ManagedCommitChange>)?.forEach({ context.delete($0) })
        commit.changes.forEach { (change) in
            let _change: ManagedCommitChange = context.make()
            _change.update(change)
            addToCommitChanges(_change)
        }
        
        if let integration = integration {
            if ManagedRevisionBlueprint.revisionBlueprint(withCommit: self, andIntegration: integration, in: context) == nil {
                PersistentContainer.logger.info("Creating REVISION_BLUEPRINT for Commit [\(commit.id)] and Integration [\(integration.identifier ?? "")]")
                let blueprint: ManagedRevisionBlueprint = context.make()
                blueprint.commit = self
                blueprint.integration = integration
            }
        }
    }
}

extension SourceControl.Commit {
    init(_ commit: ManagedCommit) {
        self.init(id: commit.commitHash ?? "")
        message = commit.message ?? ""
        date = commit.date ?? Date()
        if let contributor = commit.commitContributor {
            self.contributor = SourceControl.Contributor(contributor)
        }
        if let changes = commit.commitChanges as? Set<ManagedCommitChange> {
            self.changes = changes.map({ SourceControl.Change($0) })
        }
        if let blueprints = commit.revisionBlueprints as? Set<ManagedRevisionBlueprint>, !blueprints.isEmpty {
            integrationId = blueprints.first?.integration?.identifier
        }
        remoteId = commit.repository?.identifier
    }
}
#endif
