import Foundation
#if canImport(CoreData)
import CoreData

@objc(CommitChange)
public class CommitChange: NSManagedObject {
    
    @NSManaged public var filePath: String?
    @NSManaged public var statusRawValue: Int16
    @NSManaged public var commit: Commit?
    
}

#endif
