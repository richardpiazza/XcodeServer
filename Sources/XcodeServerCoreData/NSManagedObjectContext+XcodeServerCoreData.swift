import Foundation
import XcodeServerCommon
#if canImport(CoreData)
import CoreData

// MARK: - Bots
public extension NSManagedObjectContext {
    /// Retrieves all `Bot` entities from the Core Data `NSManagedObjectContext`
    func bots() -> [Bot] {
        let fetchRequest = NSFetchRequest<Bot>(entityName: Bot.entityName)
        do {
            return try self.fetch(fetchRequest)
        } catch {
            print(error)
        }
        
        return []
    }
    
    /// Retrieves the first `Bot` entity from the Core Data `NSManagedObjectContext`
    /// that matches the specified identifier.
    func bot(withIdentifier identifier: String) -> Bot? {
        let fetchRequest = NSFetchRequest<Bot>(entityName: Bot.entityName)
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

// MARK: - Commits
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

// MARK: - Devices
public extension NSManagedObjectContext {
    /// Retrieves all `Device` entities from the Core Data `NSManagedObjectContext`
    func devices() -> [Device] {
        let fetchRequest = NSFetchRequest<Device>(entityName: Device.entityName)
        do {
            return try self.fetch(fetchRequest)
        } catch {
            print(error)
        }
        
        return []
    }
    
    /// Retrieves the first `Device` entity from the Core Data `NSManagedObjectContext`
    /// that matches the specified identifier.
    func device(withIdentifier identifier: String) -> Device? {
        let fetchRequest = NSFetchRequest<Device>(entityName: Device.entityName)
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

// MARK: - Integrations
public extension NSManagedObjectContext {
    /// Retrieves all `Integration` entities from the Core Data `NSManagedObjectContext`
    func integrations() -> [Integration] {
        let request: NSFetchRequest<Integration> = Integration.fetchRequest()
        
        do {
            return try fetch(request)
        } catch {
            print(error)
        }
        
        return []
    }
    
    /// Retrieves the first `Integration` entity from the Core Data `NSManagedObjectContext`
    /// that matches the specified identifier.
    func integration(withIdentifier identifier: String) -> Integration? {
        let request: NSFetchRequest<Integration> = Integration.fetchRequest()
        request.predicate = NSPredicate(format: "identifier = %@", argumentArray: [identifier])
        
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
    
    /// All Integrations that are not in the 'completed' step.
    func incompleteIntegrations() -> [Integration] {
        let request: NSFetchRequest<Integration> = Integration.fetchRequest()
        request.predicate = NSPredicate(format: "currentStepRawValue != %@", argumentArray: [IntegrationStep.completed.rawValue])
        
        do {
            return try fetch(request)
        } catch {
            print(error)
        }
        
        return []
    }
}

// MARK: - Repositories
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

// MARK: - Revision Blueprints
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

// MARK: - Servers
public extension NSManagedObjectContext {
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
    
    func serversLastUpdatedOnOrBefore(_ date: Date) -> [Server] {
        let fetchRequest = NSFetchRequest<Server>(entityName: Server.entityName)
        fetchRequest.predicate = NSPredicate(format: "lastUpdate == nil OR lastUpdate < %@", argumentArray: [date])
        
        do {
            return try self.fetch(fetchRequest)
        } catch {
            print(error)
        }
        
        return []
    }
}

#endif
