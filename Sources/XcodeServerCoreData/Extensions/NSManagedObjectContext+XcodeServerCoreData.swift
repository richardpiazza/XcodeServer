import Foundation
import XcodeServer
#if canImport(CoreData)
import CoreData

extension NSManagedObjectContext {
    /// Inserts a new entity for the specified type.
    ///
    /// When initializing multiple models with duplicate entities, the standard `NSManagedObject.init(context:)` will
    /// have difficulties disambiguating the references. Using `NSEntityDescription.insertNewObject(forEntityName:into:)`
    /// do not have the problem.
    func make<T>() -> T where T: NSManagedObject {
        return NSEntityDescription.insertNewObject(forEntityName: T.entityName, into: self) as! T
    }
}

// MARK: - Bots
extension NSManagedObjectContext {
    /// Retrieves all `Bot` entities from the Core Data `NSManagedObjectContext`
    func bots() -> [XcodeServerCoreData.Bot] {
        let fetchRequest = NSFetchRequest<XcodeServerCoreData.Bot>(entityName: XcodeServerCoreData.Bot.entityName)
        do {
            return try self.fetch(fetchRequest)
        } catch {
            InternalLog.coreData.error("", error: error)
        }
        
        return []
    }
    
    /// Retrieves all `Bot` entities for a specific `Server`.
    func bots(forServer id: XcodeServer.Server.ID) -> [XcodeServerCoreData.Bot] {
        let fetchRequest = NSFetchRequest<XcodeServerCoreData.Bot>(entityName: XcodeServerCoreData.Bot.entityName)
        fetchRequest.predicate = NSPredicate(format: "server.fqdn = %@", argumentArray: [id])
        do {
            return try self.fetch(fetchRequest)
        } catch {
            InternalLog.coreData.error("", error: error)
            return []
        }
    }
    
    /// Retrieves the first `Bot` entity from the Core Data `NSManagedObjectContext`
    /// that matches the specified identifier.
    func bot(withIdentifier identifier: String) -> XcodeServerCoreData.Bot? {
        let fetchRequest = NSFetchRequest<XcodeServerCoreData.Bot>(entityName: XcodeServerCoreData.Bot.entityName)
        fetchRequest.predicate = NSPredicate(format: "identifier = %@", argumentArray: [identifier])
        do {
            let results = try self.fetch(fetchRequest)
            if let result = results.first {
                return result
            }
        } catch {
            InternalLog.coreData.error("", error: error)
        }
        
        return nil
    }
}

// MARK: - Commits
extension NSManagedObjectContext {
    /// Retrieves all `Commit` entities from the Core Data `NSManagedObjectContext`
    func commits() -> [XcodeServerCoreData.Commit] {
        let request = NSFetchRequest<XcodeServerCoreData.Commit>(entityName: XcodeServerCoreData.Commit.entityName)
        
        do {
            return try fetch(request)
        } catch {
            InternalLog.coreData.error("", error: error)
        }
        
        return []
    }
    
    /// Retrieves the first `Commit` entity from the Core Data `NSManagedObjectContext`
    /// that matches the specified Hash identifier.
    func commit(withHash identifier: String) -> XcodeServerCoreData.Commit? {
        let request = NSFetchRequest<XcodeServerCoreData.Commit>(entityName: XcodeServerCoreData.Commit.entityName)
        request.predicate = NSPredicate(format: "commitHash = %@", argumentArray: [identifier])
        
        do {
            let results = try fetch(request)
            if let result = results.first {
                return result
            }
        } catch {
            InternalLog.coreData.error("", error: error)
        }
        
        return nil
    }
    
    func incompleteCommits() -> [XcodeServerCoreData.Commit] {
        let request = NSFetchRequest<XcodeServerCoreData.Commit>(entityName: XcodeServerCoreData.Commit.entityName)
        request.predicate = NSPredicate(format: "message == nil OR commitContributor == nil", argumentArray: nil)
        
        do {
            return try fetch(request)
        } catch {
            InternalLog.coreData.error("", error: error)
        }
        
        return []
    }
}

// MARK: - Devices
extension NSManagedObjectContext {
    /// Retrieves all `Device` entities from the Core Data `NSManagedObjectContext`
    func devices() -> [XcodeServerCoreData.Device] {
        let fetchRequest = NSFetchRequest<XcodeServerCoreData.Device>(entityName: XcodeServerCoreData.Device.entityName)
        do {
            return try self.fetch(fetchRequest)
        } catch {
            InternalLog.coreData.error("", error: error)
        }
        
        return []
    }
    
    /// Retrieves the first `Device` entity from the Core Data `NSManagedObjectContext`
    /// that matches the specified identifier.
    func device(withIdentifier identifier: String) -> XcodeServerCoreData.Device? {
        let fetchRequest = NSFetchRequest<XcodeServerCoreData.Device>(entityName: XcodeServerCoreData.Device.entityName)
        fetchRequest.predicate = NSPredicate(format: "identifier = %@", argumentArray: [identifier])
        do {
            let results = try self.fetch(fetchRequest)
            if let result = results.first {
                return result
            }
        } catch {
            InternalLog.coreData.error("", error: error)
        }
        
        return nil
    }
}

// MARK: - Integrations
extension NSManagedObjectContext {
    /// Retrieves all `Integration` entities from the Core Data `NSManagedObjectContext`
    func integrations() -> [XcodeServerCoreData.Integration] {
        let request = NSFetchRequest<XcodeServerCoreData.Integration>(entityName: XcodeServerCoreData.Integration.entityName)
        
        do {
            return try fetch(request)
        } catch {
            InternalLog.coreData.error("", error: error)
        }
        
        return []
    }
    
    /// Retrieves all `Integration` entities for the specified `Bot`.
    func integrations(forBot id: XcodeServer.Bot.ID) -> [XcodeServerCoreData.Integration] {
        let request = NSFetchRequest<XcodeServerCoreData.Integration>(entityName: XcodeServerCoreData.Integration.entityName)
        request.predicate = NSPredicate(format: "bot.identifier = %@", argumentArray: [id])
        do {
            return try fetch(request)
        } catch {
            InternalLog.coreData.error("", error: error)
            return []
        }
    }
    
    /// Retrieves the first `Integration` entity from the Core Data `NSManagedObjectContext`
    /// that matches the specified identifier.
    func integration(withIdentifier identifier: String) -> XcodeServerCoreData.Integration? {
        let request = NSFetchRequest<XcodeServerCoreData.Integration>(entityName: XcodeServerCoreData.Integration.entityName)
        request.predicate = NSPredicate(format: "identifier = %@", argumentArray: [identifier])
        
        do {
            let results = try fetch(request)
            if let result = results.first {
                return result
            }
        } catch {
            InternalLog.coreData.error("", error: error)
        }
        
        return nil
    }
    
    /// All Integrations that are not in the 'completed' step.
    func incompleteIntegrations() -> [XcodeServerCoreData.Integration] {
        let request = NSFetchRequest<XcodeServerCoreData.Integration>(entityName: XcodeServerCoreData.Integration.entityName)
        request.predicate = NSPredicate(format: "currentStepRawValue != %@", argumentArray: [XcodeServer.Integration.Step.completed.rawValue])
        
        do {
            return try fetch(request)
        } catch {
            InternalLog.coreData.error("", error: error)
        }
        
        return []
    }
}

// MARK: - Issues
extension NSManagedObjectContext {
    ///
    func issue(withIdentifier identifier: String) -> XcodeServerCoreData.Issue? {
        let fetchRequest = NSFetchRequest<XcodeServerCoreData.Issue>(entityName: XcodeServerCoreData.Issue.entityName)
        fetchRequest.predicate = NSPredicate(format: "identifier = %@", argumentArray: [identifier])
        do {
            return try self.fetch(fetchRequest).first
        } catch {
            InternalLog.coreData.error("", error: error)
        }
        
        return nil
    }
}

// MARK: - Repositories
extension NSManagedObjectContext {
    /// Retrieves all `Repository` entities from the Core Data `NSManagedObjectContext`
    func repositories() -> [XcodeServerCoreData.Repository] {
        let fetchRequest = NSFetchRequest<XcodeServerCoreData.Repository>(entityName: XcodeServerCoreData.Repository.entityName)
        do {
            return try self.fetch(fetchRequest)
        } catch {
            InternalLog.coreData.error("", error: error)
        }
        
        return []
    }
    
    /// Retrieves the first `Repository` entity from the Core Data `NSManagedObjectContext`
    /// that matches the specified identifier.
    func repository(withIdentifier identifier: String) -> XcodeServerCoreData.Repository? {
        let fetchRequest = NSFetchRequest<XcodeServerCoreData.Repository>(entityName: XcodeServerCoreData.Repository.entityName)
        fetchRequest.predicate = NSPredicate(format: "identifier = %@", argumentArray: [identifier])
        do {
            let results = try self.fetch(fetchRequest)
            if let result = results.first {
                return result
            }
        } catch {
            InternalLog.coreData.error("", error: error)
        }
        
        return nil
    }
}

// MARK: - Revision Blueprints
extension NSManagedObjectContext {
    /// Retrieves all `RevisionBlueprint` entities from the Core Data `NSManagedObjectContext`
    func revisionBlueprints() -> [XcodeServerCoreData.RevisionBlueprint] {
        let fetchRequest = NSFetchRequest<XcodeServerCoreData.RevisionBlueprint>(entityName: XcodeServerCoreData.RevisionBlueprint.entityName)
        do {
            return try self.fetch(fetchRequest)
        } catch {
            InternalLog.coreData.error("", error: error)
        }
        
        return []
    }
    
    /// Retrieves the first `RevisionBlueprint` entity from the Core Data `NSManagedObjectContext`
    /// that has a specific `Commit` and `Integration` associated with it.
    func revisionBlueprint(withCommit commit: XcodeServerCoreData.Commit, andIntegration integration: XcodeServerCoreData.Integration) -> XcodeServerCoreData.RevisionBlueprint? {
        let fetchRequest = NSFetchRequest<XcodeServerCoreData.RevisionBlueprint>(entityName: XcodeServerCoreData.RevisionBlueprint.entityName)
        fetchRequest.predicate = NSPredicate(format: "commit = %@ AND integration = %@", argumentArray: [commit, integration])
        do {
            let results = try self.fetch(fetchRequest)
            if let result = results.first {
                return result
            }
        } catch {
            InternalLog.coreData.error("", error: error)
        }
        
        return nil
    }
}

// MARK: - Servers
extension NSManagedObjectContext {
    /// Retrieves all `Server` entities from the Core Data `NSManagedObjectContext`
    func servers() -> [XcodeServerCoreData.Server] {
        let fetchRequest = NSFetchRequest<XcodeServerCoreData.Server>(entityName: XcodeServerCoreData.Server.entityName)
        do {
            return try self.fetch(fetchRequest)
        } catch {
            InternalLog.coreData.error("", error: error)
        }
        
        return []
    }
    
    /// Retrieves the first `Server` entity from the Core Data `NSManagedObjectContext`
    /// that matches the specified FQDN identifier.
    func server(withFQDN identifier: String) -> XcodeServerCoreData.Server? {
        let fetchRequest = NSFetchRequest<XcodeServerCoreData.Server>(entityName: XcodeServerCoreData.Server.entityName)
        fetchRequest.predicate = NSPredicate(format: "fqdn = %@", argumentArray: [identifier])
        do {
            let results = try self.fetch(fetchRequest)
            if let result = results.first {
                return result
            }
        } catch {
            InternalLog.coreData.error("", error: error)
        }
        
        return nil
    }
    
    func serversLastUpdatedOnOrBefore(_ date: Date) -> [XcodeServerCoreData.Server] {
        let fetchRequest = NSFetchRequest<XcodeServerCoreData.Server>(entityName: XcodeServerCoreData.Server.entityName)
        fetchRequest.predicate = NSPredicate(format: "lastUpdate == nil OR lastUpdate < %@", argumentArray: [date])
        
        do {
            return try self.fetch(fetchRequest)
        } catch {
            InternalLog.coreData.error("", error: error)
        }
        
        return []
    }
}

#endif
