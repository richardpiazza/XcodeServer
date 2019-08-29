import Foundation
import CoreData

public extension Filter {

    @NSManaged var architectureType: NSNumber?
    @NSManaged var filterType: NSNumber?
    @NSManaged var deviceSpecification: DeviceSpecification?
    @NSManaged var platform: Platform?

}
