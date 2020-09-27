import XcodeServer
#if canImport(CoreData)
import CoreData

public extension XcodeServerCoreData.Commit {
    func update(_ commit: SourceControl.Commit, context: NSManagedObjectContext) {
        commitHash = commit.id
        message = commit.message
        date = commit.date
        
        if let existing = commitContributor {
            existing.update(commit.contributor)
        } else {
            let new = CommitContributor(context: context)
            new.update(commit.contributor)
            commitContributor = new
        }
        
        let removed = (commitChanges ?? []).filter({ (change) -> Bool in
            return !commit.changes.contains(where: {
                $0.status == change.statusRawValue &&
                $0.filePath == change.filePath
            })
        })
        
        let added = commit.changes.filter { (change) -> Bool in
            return !(commitChanges ?? []).contains(where: {
                $0.statusRawValue == change.status &&
                $0.filePath == change.filePath
            })
        }
        
        removed.forEach({
            commitChanges?.remove($0)
        })
        
        added.forEach({
            let new = CommitChange(context: context)
            new.update($0)
            commitChanges?.insert(new)
        })
    }
}

/*
 extension XcodeServerCoreData.Commit {
     public func update(withCommit commit: XCSRepositoryCommit, integration: XcodeServerCoreData.Integration? = nil) {
         guard let moc = self.managedObjectContext else {
             return
         }
         
         self.message = commit.message
         self.date = commit.timestamp
         
         if let contributor = commit.contributor {
             if let existing = commitContributor {
                 existing.update(withCommitContributor: contributor)
             } else {
                 let new = CommitContributor(context: moc)
                 new.update(withCommitContributor: contributor)
                 commitContributor = new
             }
         }
         
         if let filePaths = commit.commitChangeFilePaths {
             for commitChange in filePaths {
                 guard self.commitChanges?.contains(where: { (cc: CommitChange) -> Bool in return cc.filePath == commitChange.filePath }) == false else {
                     continue
                 }
                 
                 let new = CommitChange(context: moc)
                 new.update(withCommitChange: commitChange)
                 new.commit = self
             }
         }
         
         if let integration = integration {
             guard moc.revisionBlueprint(withCommit: self, andIntegration: integration) == nil else {
                 return
             }
             
             let new = RevisionBlueprint(context: moc)
             new.commit = self
             new.integration = integration
         }
     }
 }
 */

#endif
