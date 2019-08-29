import Foundation
import CoreData

public extension Bot {
    
    @nonobjc class func fetchRequest() -> NSFetchRequest<Bot> {
        return NSFetchRequest<Bot>(entityName: "Bot")
    }
    
    @NSManaged var identifier: String
    @NSManaged var lastUpdate: Date?
    @NSManaged var name: String?
    @NSManaged var type: NSNumber?
    @NSManaged var revision: String?
    @NSManaged var configuration: Configuration?
    @NSManaged var integrations: Set<Integration>?
    @NSManaged var stats: Stats?
    @NSManaged var xcodeServer: XcodeServer?
    
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
