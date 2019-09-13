import Foundation
#if canImport(CoreData)
import CoreData

@objc(RevisionBlueprint)
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

public extension NSManagedObjectContext {
    /// Retrieves all `RevisionBlueprint` entities from the Core Data `NSManagedObjectContext`
    func revisionBlueprints() -> [RevisionBlueprint] {
        let fetchRequest = NSFetchRequest<RevisionBlueprint>(entityName: RevisionBlueprint.entityName)
        do {
            return try self.fetch(fetchRequest)
        } catch {
            print(error)
        }
        
        return []
    }
    
    /// Retrieves the first `RevisionBlueprint` entity from the Core Data `NSManagedObjectContext`
    /// that has a specific `Commit` and `Integration` associated with it.
    func revisionBlueprint(withCommit commit: Commit, andIntegration integration: Integration) -> RevisionBlueprint? {
        let fetchRequest = NSFetchRequest<RevisionBlueprint>(entityName: RevisionBlueprint.entityName)
        fetchRequest.predicate = NSPredicate(format: "commit = %@ AND integration = %@", argumentArray: [commit, integration])
        do {
            let results = try self.fetch(fetchRequest)
            if let result = results.first {
                return result
            }
        } catch {
            print(error)
        }
        
        return nil
    }
}

#endif
