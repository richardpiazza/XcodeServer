import Foundation
import CoreData

public extension Platform {

    @NSManaged var buildNumber: String?
    @NSManaged var displayName: String?
    @NSManaged var identifier: String?
    @NSManaged var platformIdentifier: String?
    @NSManaged var revision: String?
    @NSManaged var simulatorIdentifier: String?
    @NSManaged var version: String?
    @NSManaged var filter: Filter?

}
