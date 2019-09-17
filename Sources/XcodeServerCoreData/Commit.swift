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
    
    @nonobjc class func fetchRequest() -> NSFetchRequest<Commit> {
        return NSFetchRequest<Commit>(entityName: entityName)
    }
    
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
        let request = NSFetchRequest<Commit>(entityName: Commit.entityName)
        
        do {
            return try fetch(request)
        } catch {
            print(error)
        }
        
        return []
    }
    
    /// Retrieves the first `Commit` entity from the Core Data `NSManagedObjectContext`
    /// that matches the specified Hash identifier.
    func commit(withHash identifier: String) -> Commit? {
        let request = NSFetchRequest<Commit>(entityName: Commit.entityName)
        request.predicate = NSPredicate(format: "commitHash = %@", argumentArray: [identifier])
        
        do {
            let results = try fetch(request)
            if let result = results.first {
                return result
            }
        } catch {
            print(error)
        }
        
        return nil
    }
    
    func incompleteCommits() -> [Commit] {
        let request: NSFetchRequest<Commit> = Commit.fetchRequest()
        request.predicate = NSPredicate(format: "message == nil OR commitContributor == nil", argumentArray: nil)
        
        do {
            return try fetch(request)
        } catch {
            print(error)
        }
        
        return []
    }
}

#endif
