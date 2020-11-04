import Foundation
#if canImport(CoreData)
import CoreData

@objc(CommitChange)
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
#endif
