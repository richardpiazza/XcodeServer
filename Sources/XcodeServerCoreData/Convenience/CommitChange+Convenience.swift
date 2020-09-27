import XcodeServer
#if canImport(CoreData)
import CoreData

public extension CommitChange {
    func update(_ change: SourceControl.Change) {
        statusRawValue = Int16(change.status)
        filePath = change.filePath
    }
}

/*
 extension XcodeServerCoreData.CommitChange {
     public func update(withCommitChange change: XCSCommitChangeFilePath) {
         self.statusRawValue = Int16(change.status)
         self.filePath = change.filePath
     }
 }
 */

#endif
