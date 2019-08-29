import Foundation
import CoreData

public extension CommitChange {

    @NSManaged var filePath: String?
    @NSManaged var status: NSNumber?
    @NSManaged var commit: Commit?

}
