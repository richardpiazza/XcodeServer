import Foundation
import XcodeServerCommon
#if canImport(CoreData)
import CoreData

@objc(Commit)
public class Commit: NSManagedObject {
    
    public convenience init?(managedObjectContext: NSManagedObjectContext, identifier: String, repository: Repository) {
        self.init(managedObjectContext: managedObjectContext)
        self.commitHash = identifier
        self.repository = repository
    }
    
}

// MARK: - CoreData Properties
public extension Commit {
    
    @NSManaged var commitHash: String
    @NSManaged var message: String?
    @NSManaged var date: Date?
    @NSManaged var commitChanges: Set<CommitChange>?
    @NSManaged var commitContributor: CommitContributor?
    @NSManaged var repository: Repository?
    @NSManaged var revisionBlueprints: Set<RevisionBlueprint>?
    
}

public extension NSManagedObjectContext {
    /// Retrieves all `Commit` entities from the Core Data `NSManagedObjectContext`
    func commits() -> [Commit] {
        let fetchRequest = NSFetchRequest<Commit>(entityName: Commit.entityName)
        do {
            return try self.fetch(fetchRequest)
        } catch {
            print(error)
        }
        
        return []
    }
    
    /// Retrieves the first `Commit` entity from the Core Data `NSManagedObjectContext`
    /// that matches the specified Hash identifier.
    func commit(withHash identifier: String) -> Commit? {
        let fetchRequest = NSFetchRequest<Commit>(entityName: Commit.entityName)
        fetchRequest.predicate = NSPredicate(format: "commitHash = %@", argumentArray: [identifier])
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
