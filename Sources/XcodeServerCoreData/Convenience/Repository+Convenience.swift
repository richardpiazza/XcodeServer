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
        identifier = blueprint.primaryRemoteIdentifier
        if let remote = blueprint.remotes.first(where: { $0.id == identifier }) {
            system = remote.system
            url = remote.url
        }
        if let location = blueprint.locations[identifier] {
            branchIdentifier = location.id
            branchOptions = Int16(location.branchOptions)
            locationType = location.locationType
        }
        if let _ = blueprint.authenticationStrategies[identifier] {
        }
    }
    
    func update(_ commits: Set<SourceControl.Commit>, integration: XcodeServerCoreData.Integration? = nil, context: NSManagedObjectContext) {
        for commit in commits {
            let _commit: Commit
            if let entity = context.commit(withHash: commit.id) {
                _commit = entity
            } else {
                _commit = Commit(context: context)
                _commit.repository = self
                _commit.update(commit, context: context)
            }
            
            guard let integration = integration else {
                return
            }
            
            if context.revisionBlueprint(withCommit: _commit, andIntegration: integration) == nil {
                let link = RevisionBlueprint(context: context)
                link.commit = _commit
                link.integration = integration
            }
        }
    }
}

/*
 extension XcodeServerCoreData.Repository {
     public func update(withRevisionBlueprint blueprint: XCSRepositoryBlueprint, integration: Integration? = nil) {
         guard let moc = self.managedObjectContext else {
             return
         }
         
         guard blueprint.repositoryIds.contains(self.identifier) else {
             return
         }
         
         if let workingCopyStates = blueprint.workingCopyStates, let state = workingCopyStates[self.identifier] {
             self.workingCopyState = state as NSNumber?
         }
         
         if let workingCopyPaths = blueprint.workingCopyPaths, let path = workingCopyPaths[self.identifier] {
             self.workingCopyPath = path
         }
         
         if let remoteRepositorys = blueprint.remoteRepositories {
             if let remoteRepository = remoteRepositorys.filter({ (repo: XCSRemoteRepository) -> Bool in
                 return repo.identifier == self.identifier
             }).first {
                 self.system = remoteRepository.system
                 self.url = remoteRepository.url
             }
         }
         
         guard let blueprintLocation = blueprint.locations?[self.identifier] else {
             return
         }
         
         self.branchIdentifier = blueprintLocation.branchIdentifier
         self.branchOptions = Int16(blueprintLocation.branchOptions ?? 0)
         self.locationType = blueprintLocation.locationType
         
         guard let integration = integration else {
             return
         }
         
         guard let commitHash = blueprintLocation.locationRevision else {
             return
         }
         
         let commit: Commit
         if let c = moc.commit(withHash: commitHash) {
             commit = c
         } else {
             commit = Commit(context: moc)
             commit.commitHash = commitHash
             commit.repository = self
         }
         
         guard moc.revisionBlueprint(withCommit: commit, andIntegration: integration) == nil else {
             return
         }
         
         let new = RevisionBlueprint(context: moc)
         new.commit = commit
         new.integration = integration
     }
     
     public func update(withIntegrationCommits commits: [XCSCommit], integration: Integration? = nil) {
         for integrationCommit in commits {
             if let integrationCommits = integrationCommit.commits {
                 for (key, value) in integrationCommits {
                     guard key == self.identifier else {
                         continue
                     }
                     
                     self.update(withCommits: value, integration: integration)
                 }
             }
         }
     }
     
     public func update(withCommits commits: [XCSRepositoryCommit], integration: Integration? = nil) {
         guard let moc = self.managedObjectContext else {
             return
         }
         
         for commitsCommit in commits {
             guard let hash = commitsCommit.hash else {
                 continue
             }
             
             let commit: Commit
             if let c = moc.commit(withHash: hash) {
                 commit = c
             } else {
                 commit = Commit(context: moc)
                 commit.commitHash = hash
                 commit.repository = self
             }
             
             commit.update(withCommit: commitsCommit, integration: integration)
         }
     }
 }
 */

#endif
