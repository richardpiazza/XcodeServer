import Foundation
import CoreData

public extension Trigger {

    @NSManaged var name: String?
    @NSManaged var phase: NSNumber?
    @NSManaged var scriptBody: String?
    @NSManaged var type: NSNumber?
    @NSManaged var conditions: Conditions?
    @NSManaged var configuration: Configuration?
    @NSManaged var emailConfiguration: EmailConfiguration?

}
