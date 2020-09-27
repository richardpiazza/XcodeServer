import Foundation
#if canImport(CoreData)
import CoreData

@objc(Bot)
public class Bot: NSManagedObject {
    
    @NSManaged public var configuration: Configuration?
    @NSManaged public var identifier: String
    @NSManaged public var integrationCounter: Int32
    @NSManaged public var integrations: Set<Integration>?
    @NSManaged public var lastUpdate: Date?
    @NSManaged public var name: String?
    @NSManaged public var requiresUpgrade: Bool
    @NSManaged public var stats: Stats?
    @NSManaged public var typeRawValue: Int16
    @NSManaged public var server: Server?
    
    @objc(addIntegrationsObject:)
    @NSManaged public func addToIntegrations(_ value: Integration)
    
    @objc(removeIntegrationsObject:)
    @NSManaged public func removeFromIntegrations(_ value: Integration)
    
    @objc(addIntegrations:)
    @NSManaged public func addToIntegrations(_ values: Set<Integration>)
    
    @objc(removeIntegrations:)
    @NSManaged public func removeFromIntegrations(_ values: Set<Integration>)
    
}

#endif
