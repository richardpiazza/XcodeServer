import Foundation
import CoreData
import XcodeServerCommon
import XcodeServerAPI

public class Commit: NSManagedObject {
    
    public convenience init?(managedObjectContext: NSManagedObjectContext, identifier: String, repository: Repository) {
        self.init(managedObjectContext: managedObjectContext)
        self.commitHash = identifier
        self.repository = repository
    }
    
    public func update(withCommit commit: XCSRepositoryCommit, integration: Integration? = nil) {
        guard let moc = self.managedObjectContext else {
            return
        }
        
        self.message = commit.message
        if let commitTimestamp = commit.timestamp {
            // TODO: Commit Timestamp should be a DATE!
            self.timestamp = dateFormatter.string(from: commitTimestamp)
        }
        
        if let contributor = commit.contributor {
            if self.commitContributor == nil {
                self.commitContributor = CommitContributor(managedObjectContext: moc, commit: self)
            }
            
            self.commitContributor?.update(withCommitContributor: contributor)
        }
        
        if let filePaths = commit.commitChangeFilePaths {
            for commitChange in filePaths {
                guard self.commitChanges?.contains(where: { (cc: CommitChange) -> Bool in return cc.filePath == commitChange.filePath }) == false else {
                    continue
                }
                
                if let change = CommitChange(managedObjectContext: moc, commit: self) {
                    change.update(withCommitChange: commitChange)
                }
            }
        }
        
        if let integration = integration {
            guard moc.revisionBlueprint(withCommit: self, andIntegration: integration) == nil else {
                return
            }
            
            let _ = RevisionBlueprint(managedObjectContext: moc, commit: self, integration: integration)
        }
    }
    
    public var commitTimestamp: Date? {
        guard let timestamp = self.timestamp else {
            return nil
        }
        
        return dateFormatter.date(from: timestamp)
    }
}
