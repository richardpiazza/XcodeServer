import XcodeServer
#if canImport(CoreData)
import CoreData

public extension XcodeServerCoreData.Commit {
    func update(_ commit: SourceControl.Commit, integration: XcodeServerCoreData.Integration? = nil, context: NSManagedObjectContext) {
        if commitContributor == nil {
            InternalLog.coreData.info("Creating COMMIT_CONTRIBUTOR for Commit [\(commit.id)]")
            commitContributor = CommitContributor(context: context)
        }
        
        commitHash = commit.id
        message = commit.message
        date = commit.date
        commitContributor?.update(commit.contributor)
        
//        commitChanges?.forEach({ context.delete($0) })
//        commit.changes.forEach { (change) in
//            let _change = CommitChange(context: context)
//            _change.update(change)
//            _change.commit = self
//        }
        
        if let integration = integration {
            if context.revisionBlueprint(withCommit: self, andIntegration: integration) == nil {
                InternalLog.coreData.info("Creating REVISION_BLUEPRINT for Commit [\(commitHash)] and Integration [\(integration.identifier)]")
                let blueprint = RevisionBlueprint(context: context)
                blueprint.commit = self
                blueprint.integration = integration
            }
        }
    }
}
#endif
