import Foundation
#if canImport(CoreData)
import CoreData

@objc(CommitContributor)
public class CommitContributor: NSManagedObject {

    @NSManaged public var displayName: String?
    @NSManaged public var emailsData: Data?
    @NSManaged public var name: String?
    @NSManaged public var commit: Commit?
    
}

#endif
