import Foundation
import CoreData

public extension CommitContributor {

    @NSManaged var displayName: String?
    @NSManaged var emailsData: Data?
    @NSManaged var name: String?
    @NSManaged var commit: Commit?

}
