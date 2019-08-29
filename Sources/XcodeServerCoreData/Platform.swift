import Foundation
import CoreData
import XcodeServerAPI

public class Platform: NSManagedObject {
    
    public convenience init?(managedObjectContext: NSManagedObjectContext, filter: Filter) {
        self.init(managedObjectContext: managedObjectContext)
        self.filter = filter
    }
    
    public func update(withPlatform platform: XCSPlatform) {
        self.identifier = platform._id
        self.revision = platform._rev
        self.displayName = platform.displayName
        self.simulatorIdentifier = platform.simulatorIdentifier
        self.platformIdentifier = platform.identifier
        self.buildNumber = platform.buildNumber
        self.version = platform.version
    }
}
