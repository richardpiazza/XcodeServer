import Foundation
import CoreDataPlus
import XcodeServer
#if canImport(CoreData)
import CoreData

public class ManagedCommitChange: NSManagedObject {

}

extension ManagedCommitChange {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedCommitChange> {
        return NSFetchRequest<ManagedCommitChange>(entityName: "ManagedCommitChange")
    }

    @NSManaged public var filePath: String?
    @NSManaged public var statusRawValue: Int16
    @NSManaged public var commit: ManagedCommit?

}

extension ManagedCommitChange {
    func update(_ change: SourceControl.Change) {
        statusRawValue = Int16(change.status)
        filePath = change.filePath
    }
}

extension SourceControl.Change {
    init(_ change: ManagedCommitChange) {
        self.init()
        filePath = change.filePath ?? ""
        status = Int(change.statusRawValue)
    }
}
#endif
