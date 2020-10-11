import XcodeServer
#if canImport(CoreData)
import CoreData

public extension XcodeServerCoreData.Commit {
    func update(_ commit: SourceControl.Commit, integration: XcodeServerCoreData.Integration? = nil, context: NSManagedObjectContext) {
        if commitContributor == nil {
            commitContributor = CommitContributor(context: context)
        }
        
        commitChanges?.removeAll()
        
        commitHash = commit.id
        message = commit.message
        date = commit.date
        commitContributor?.update(commit.contributor)
        commit.changes.forEach { (change) in
            let _change = CommitChange(context: context)
            _change.update(change)
            commitChanges?.insert(_change)
        }
        
        if let integration = integration {
            if context.revisionBlueprint(withCommit: self, andIntegration: integration) == nil {
                let blueprint = RevisionBlueprint(context: context)
                blueprint.commit = self
                blueprint.integration = integration
            }
        }
    }
}
#endif
