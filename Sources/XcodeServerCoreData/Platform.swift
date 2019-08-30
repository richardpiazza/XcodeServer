import Foundation
import CoreData

public class Platform: NSManagedObject {
    
    public convenience init?(managedObjectContext: NSManagedObjectContext, filter: Filter) {
        self.init(managedObjectContext: managedObjectContext)
        self.filter = filter
    }
}
