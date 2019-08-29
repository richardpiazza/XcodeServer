import Foundation
import CoreData
import XcodeServerAPI

public class Repository: NSManagedObject {
    
    public convenience init?(managedObjectContext: NSManagedObjectContext, identifier: String) {
        self.init(managedObjectContext: managedObjectContext)
        self.identifier = identifier
    }
    
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
        self.branchOptions = blueprintLocation.branchOptions as NSNumber?
        self.locationType = blueprintLocation.locationType
        
        guard let integration = integration else {
            return
        }
        
        guard let commitHash = blueprintLocation.locationRevision else {
            return
        }
        
        var commit: Commit?
        if let c = moc.commit(withHash: commitHash) {
            commit = c
        } else if let c = Commit(managedObjectContext: moc, identifier: commitHash, repository: self) {
            commit = c
        }
        
        if let commit = commit {
            guard moc.revisionBlueprint(withCommit: commit, andIntegration: integration) == nil else {
                return
            }
            
            let _ = RevisionBlueprint(managedObjectContext: moc, commit: commit, integration: integration)
        }
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
            
            var commit: Commit?
            if let c = moc.commit(withHash: hash) {
                commit = c
            } else if let c = Commit(managedObjectContext: moc, identifier: hash, repository: self) {
                commit = c
            }
            
            if let commit = commit {
                commit.update(withCommit: commitsCommit, integration: integration)
            }
        }
    }
}
