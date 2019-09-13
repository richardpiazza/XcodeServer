import Foundation
import CoreData

/// Represents an Xcode Server Bot.
///
/// Bots are processes that Xcode Server runs to perform integrations on the current version of a project in a source
/// code repository.
@objc(Bot)
public class Bot: NSManagedObject {
    
    public convenience init?(managedObjectContext: NSManagedObjectContext, identifier: String, server: Server) {
        self.init(managedObjectContext: managedObjectContext)
        self.identifier = identifier
        self.integrationCounter = 0
        self.requiresUpgrade = false
        self.typeRawValue = 0
        self.server = server
        self.integrations = Set<Integration>()
        self.configuration = Configuration(managedObjectContext: managedObjectContext, bot: self)
        self.stats = Stats(managedObjectContext: managedObjectContext, bot: self)
    }
}

// MARK: - CoreData Properties
public extension Bot {
    
    @nonobjc class func fetchRequest() -> NSFetchRequest<Bot> {
        return NSFetchRequest<Bot>(entityName: entityName)
    }
    
    @NSManaged var configuration: Configuration?
    @NSManaged var identifier: String
    @NSManaged var integrationCounter: Int32
    @NSManaged var integrations: Set<Integration>?
    @NSManaged var lastUpdate: Date?
    @NSManaged var name: String?
    @NSManaged var requiresUpgrade: Bool
    @NSManaged var server: Server?
    @NSManaged var stats: Stats?
    @NSManaged var typeRawValue: Int16
}

// MARK: Generated accessors for integrations
extension Bot {
    
    @objc(addIntegrationsObject:)
    @NSManaged public func addToIntegrations(_ value: Integration)
    
    @objc(removeIntegrationsObject:)
    @NSManaged public func removeFromIntegrations(_ value: Integration)
    
    @objc(addIntegrations:)
    @NSManaged public func addToIntegrations(_ values: Set<Integration>)
    
    @objc(removeIntegrations:)
    @NSManaged public func removeFromIntegrations(_ values: Set<Integration>)
    
}

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
