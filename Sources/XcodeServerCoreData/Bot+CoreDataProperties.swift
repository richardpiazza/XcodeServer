import Foundation
import CoreData

public extension Bot {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Bot> {
        return NSFetchRequest<Bot>(entityName: "Bot")
    }
    
    @NSManaged public var identifier: String
    @NSManaged public var lastUpdate: Date?
    @NSManaged public var name: String?
    @NSManaged public var type: NSNumber?
    @NSManaged public var revision: String?
    @NSManaged public var configuration: Configuration?
    @NSManaged public var integrations: Set<Integration>?
    @NSManaged public var stats: Stats?
    @NSManaged public var xcodeServer: XcodeServer?
    
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
