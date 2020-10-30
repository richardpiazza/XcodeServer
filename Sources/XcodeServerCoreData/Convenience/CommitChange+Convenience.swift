import XcodeServer
#if canImport(CoreData)
import CoreData

public extension CommitChange {
    func update(_ change: SourceControl.Change) {
        statusRawValue = Int16(change.status)
        filePath = change.filePath
    }
}
#endif
