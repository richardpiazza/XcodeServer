import Foundation
import CoreData

public class BuildResultSummary: NSManagedObject {
    
    public convenience init?(managedObjectContext: NSManagedObjectContext, integration: Integration) {
        self.init(managedObjectContext: managedObjectContext)
        self.integration = integration
    }
}
