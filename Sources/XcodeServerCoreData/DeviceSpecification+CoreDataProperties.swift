import Foundation
import CoreData

public extension DeviceSpecification {

    @NSManaged var configuration: Configuration?
    @NSManaged var filters: Set<Filter>?
    @NSManaged var devices: Set<Device>?

}
