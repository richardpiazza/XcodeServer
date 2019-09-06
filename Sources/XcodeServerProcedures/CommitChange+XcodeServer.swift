import Foundation
import XcodeServerAPI
import XcodeServerCoreData

extension CommitChange {
    public func update(withCommitChange change: XCSCommitChangeFilePath) {
        self.statusRawValue = Int16(change.status)
        self.filePath = change.filePath
    }
}
