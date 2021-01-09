import XcodeServer
import XcodeServerCoreData
import Foundation
#if canImport(CoreData)
import CoreData

//@objc(CommitChange)
public class CommitChange: NSManagedObject {

}

extension CommitChange {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CommitChange> {
        return NSFetchRequest<CommitChange>(entityName: "CommitChange")
    }

    @NSManaged public var filePath: String?
    @NSManaged public var statusRawValue: Int16
    @NSManaged public var commit: Commit?

}

public extension CommitChange {
    func update(_ change: SourceControl.Change) {
        statusRawValue = Int16(change.status)
        filePath = change.filePath
    }
}

public extension SourceControl.Change {
    init(_ change: CommitChange) {
        self.init()
        filePath = change.filePath ?? ""
        status = Int(change.statusRawValue)
    }
}
#endif
