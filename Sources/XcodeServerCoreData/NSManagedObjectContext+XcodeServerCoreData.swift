import Foundation
import CoreData

/// Extension to `NSManagedObjectContext` that has typed `NSFetchRequest` specific
/// to XCServerCoreData
public extension NSManagedObjectContext {
    
    // MARK: - Server -
    
    /// Retrieves all `Server` entities from the Core Data `NSManagedObjectContext`
    func servers() -> [Server] {
        let fetchRequest = NSFetchRequest<Server>(entityName: Server.entityName)
        do {
            return try self.fetch(fetchRequest)
        } catch {
            print(error)
        }
        
        return []
    }
    
    /// Retrieves the first `Server` entity from the Core Data `NSManagedObjectContext`
    /// that matches the specified FQDN identifier.
    func server(withFQDN identifier: String) -> Server? {
        let fetchRequest = NSFetchRequest<Server>(entityName: Server.entityName)
        fetchRequest.predicate = NSPredicate(format: "fqdn = %@", argumentArray: [identifier])
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
    
    // MARK: - Integration -
    
    /// Retrieves all `Integration` entities from the Core Data `NSManagedObjectContext`
    func integrations() -> [Integration] {
        let fetchRequest = NSFetchRequest<Integration>(entityName: Integration.entityName)
        do {
            return try self.fetch(fetchRequest)
        } catch {
            print(error)
        }
        
        return []
    }
    
    /// Retrieves the first `Integration` entity from the Core Data `NSManagedObjectContext`
    /// that matches the specified identifier.
    func integration(withIdentifier identifier: String) -> Integration? {
        let fetchRequest = NSFetchRequest<Integration>(entityName: Integration.entityName)
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
    
    // MARK: - Repository -
    
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
    
    // MARK: - Commit -
    
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
    
    // MARK: - Revision Blueprints -
    
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
