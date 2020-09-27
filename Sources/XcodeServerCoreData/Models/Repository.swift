import Foundation
#if canImport(CoreData)
import CoreData

@objc(Repository)
public class Repository: NSManagedObject {
    
    @NSManaged public var branchIdentifier: String?
    @NSManaged public var branchOptions: Int16
    @NSManaged public var identifier: String
    @NSManaged public var locationType: String?
    @NSManaged public var system: String?
    @NSManaged public var url: String?
    @NSManaged public var workingCopyPath: String?
    @NSManaged public var workingCopyState: NSNumber?
    @NSManaged public var commits: Set<Commit>?
    @NSManaged public var configurations: Set<Configuration>?
    
}

#endif
