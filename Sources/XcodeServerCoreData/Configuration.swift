import Foundation
import CoreData

public class Configuration: NSManagedObject {
    
    public convenience init?(managedObjectContext: NSManagedObjectContext, bot: Bot) {
        self.init(managedObjectContext: managedObjectContext)
        self.bot = bot
        self.deviceSpecification = DeviceSpecification(managedObjectContext: managedObjectContext, configuration: self)
    }
}
