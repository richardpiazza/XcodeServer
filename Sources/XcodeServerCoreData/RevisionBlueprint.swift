import Foundation
import CoreData

public class RevisionBlueprint: NSManagedObject {
    
    public convenience init?(managedObjectContext: NSManagedObjectContext, commit: Commit, integration: Integration) {
        self.init(managedObjectContext: managedObjectContext)
        self.commit = commit
        self.integration = integration
    }
}

// MARK: - CoreData Properties
public extension RevisionBlueprint {
    
    @NSManaged var commit: Commit?
    @NSManaged var integration: Integration?
    
}
