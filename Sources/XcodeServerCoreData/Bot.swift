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
    @NSManaged var integrations: Set<Integration>?
    @NSManaged var lastUpdate: Date?
    @NSManaged var name: String?
    @NSManaged var requiresUpgradeRawValue: NSNumber?
    @NSManaged var server: Server?
    @NSManaged var stats: Stats?
    @NSManaged var typeRawValue: NSNumber?
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

public extension Bot {
    var requiresUpgrade: Bool {
        get {
            guard let rawValue = requiresUpgradeRawValue else {
                return false
            }
            
            return Bool(exactly: rawValue) ?? false
        }
        set {
            requiresUpgradeRawValue = NSNumber(booleanLiteral: newValue)
        }
    }
    
    var botType: Int? {
        get {
            return typeRawValue?.intValue
        }
        set {
            if let value = newValue {
                typeRawValue = value as NSNumber
            } else {
                typeRawValue = nil
            }
        }
    }
}