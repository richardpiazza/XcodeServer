import XcodeServer
import XcodeServerCoreData
import Foundation
#if canImport(CoreData)
import CoreData

//@objc(CommitChange)
class CommitChange: NSManagedObject {

}

extension CommitChange {

    @nonobjc class func fetchRequest() -> NSFetchRequest<CommitChange> {
        return NSFetchRequest<CommitChange>(entityName: "CommitChange")
    }

    @NSManaged var filePath: String?
    @NSManaged var statusRawValue: Int16
    @NSManaged var commit: Commit?

}

extension CommitChange {
    func update(_ change: SourceControl.Change) {
        statusRawValue = Int16(change.status)
        filePath = change.filePath
    }
}

extension SourceControl.Change {
    init(_ change: CommitChange) {
        self.init()
        filePath = change.filePath ?? ""
        status = Int(change.statusRawValue)
    }
}
#endif
