import Foundation
import CoreData

@objc(Repository)
public class Repository: NSManagedObject {
    
    public convenience init?(managedObjectContext: NSManagedObjectContext, identifier: String) {
        self.init(managedObjectContext: managedObjectContext)
        self.identifier = identifier
        self.branchOptions = 0
    }
}

// MARK: - CoreData Properties
public extension Repository {
    
    @NSManaged var branchIdentifier: String?
    @NSManaged var branchOptions: Int16
    @NSManaged var identifier: String
    @NSManaged var locationType: String?
    @NSManaged var system: String?
    @NSManaged var url: String?
    @NSManaged var workingCopyPath: String?
    @NSManaged var workingCopyState: NSNumber?
    @NSManaged var commits: Set<Commit>?
    @NSManaged var configurations: Set<Configuration>?
    
}

public extension NSManagedObjectContext {
    /// Retrieves all `Repository` entities from the Core Data `NSManagedObjectContext`
    func repositories() -> [Repository] {
        let fetchRequest = NSFetchRequest<Repository>(entityName: Repository.entityName)
        do {
            return try self.fetch(fetchRequest)
        } catch {
            print(error)
        }
        
        return []
    }
    
    /// Retrieves the first `Repository` entity from the Core Data `NSManagedObjectContext`
    /// that matches the specified identifier.
    func repository(withIdentifier identifier: String) -> Repository? {
        let fetchRequest = NSFetchRequest<Repository>(entityName: Repository.entityName)
        fetchRequest.predicate = NSPredicate(format: "identifier = %@", argumentArray: [identifier])
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
