import Foundation
import CoreData

public class Conditions: NSManagedObject {
    
    public convenience init?(managedObjectContext: NSManagedObjectContext, trigger: Trigger) {
        self.init(managedObjectContext: managedObjectContext)
        self.trigger = trigger
    }
}
