import XcodeServer
#if canImport(CoreData)
import CoreData

public extension XcodeServerCoreData.Commit {
    func update(_ commit: SourceControl.Commit, integration: XcodeServerCoreData.Integration? = nil, context: NSManagedObjectContext) {
        if commitContributor == nil {
            InternalLog.coreData.debug("Creating COMMIT_CONTRIBUTOR for Commit [\(commit.id)]")
            commitContributor = CommitContributor(context: context)
        }
        
        commitHash = commit.id
        message = commit.message
        date = commit.date
        commitContributor?.update(commit.contributor)
        
        (commitChanges as? Set<CommitChange>)?.forEach({ context.delete($0) })
        commit.changes.forEach { (change) in
            let _change = CommitChange(context: context)
            _change.update(change)
            addToCommitChanges(_change)
        }
        
        if let integration = integration {
            if context.revisionBlueprint(withCommit: self, andIntegration: integration) == nil {
                InternalLog.coreData.debug("Creating REVISION_BLUEPRINT for Commit [\(commit.id)] and Integration [\(integration.identifier ?? "")]")
                let blueprint = RevisionBlueprint(context: context)
                blueprint.commit = self
                blueprint.integration = integration
            }
        }
    }
}
#endif
