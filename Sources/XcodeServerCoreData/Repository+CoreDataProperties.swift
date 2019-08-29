import Foundation
import CoreData

public extension Repository {

    @NSManaged var branchIdentifier: String?
    @NSManaged var branchOptions: NSNumber?
    @NSManaged var identifier: String
    @NSManaged var locationType: String?
    @NSManaged var system: String?
    @NSManaged var url: String?
    @NSManaged var workingCopyPath: String?
    @NSManaged var workingCopyState: NSNumber?
    @NSManaged var commits: Set<Commit>?
    @NSManaged var configurations: Set<Configuration>?

}
