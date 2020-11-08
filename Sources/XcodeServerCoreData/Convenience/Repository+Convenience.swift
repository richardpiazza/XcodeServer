import XcodeServer
#if canImport(CoreData)
import CoreData

public extension Repository {
    func update(_ remote: SourceControl.Remote, context: NSManagedObjectContext) {
        identifier = remote.id
        system = remote.system
        url = remote.url
        update(remote.commits, context: context)
    }
    
    func update(_ blueprint: SourceControl.Blueprint, context: NSManagedObjectContext) {
        if !blueprint.primaryRemoteIdentifier.isEmpty {
            identifier = blueprint.primaryRemoteIdentifier
        }
        
        if let remote = blueprint.remotes.first(where: { $0.id == identifier }) {
            system = remote.system
            url = remote.url
        }
        
        if let location = blueprint.locations[identifier ?? ""] {
            branchIdentifier = location.id
            branchOptions = Int16(location.branchOptions)
            locationType = location.locationType
        }
        
        if let _ = blueprint.authenticationStrategies[identifier ?? ""] {
        }
    }
    
    func update(_ commits: Set<SourceControl.Commit>, integration: XcodeServerCoreData.Integration? = nil, context: NSManagedObjectContext) {
        for commit in commits {
            let _commit: Commit
            if let existing = context.commit(withHash: commit.id) {
                _commit = existing
            } else {
                InternalLog.coreData.debug("Creating COMMIT for Repository [\(identifier ?? "")]")
                _commit = context.make()
                addToCommits(_commit)
            }
            
            _commit.update(commit, integration: integration, context: context)
        }
    }
}
#endif
