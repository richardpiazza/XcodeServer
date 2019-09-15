import Foundation
import XcodeServerAPI
#if canImport(CoreData)
import XcodeServerCoreData

extension CommitChange {
    public func update(withCommitChange change: XCSCommitChangeFilePath) {
        self.statusRawValue = Int16(change.status)
        self.filePath = change.filePath
    }
}

#endif
