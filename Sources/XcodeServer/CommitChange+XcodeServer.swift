import Foundation
import XcodeServerAPI
import XcodeServerCoreData

extension CommitChange {
    public func update(withCommitChange change: XCSCommitChangeFilePath) {
        self.status = change.status as NSNumber?
        self.filePath = change.filePath
    }
}
