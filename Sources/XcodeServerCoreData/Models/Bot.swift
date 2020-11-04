import Foundation
#if canImport(CoreData)
import CoreData

@objc(Bot)
public class Bot: NSManagedObject {

}

extension Bot {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Bot> {
        return NSFetchRequest<Bot>(entityName: "Bot")
    }

    @NSManaged public var identifier: String?
    @NSManaged public var integrationCounter: Int32
    @NSManaged public var lastUpdate: Date?
    @NSManaged public var name: String?
    @NSManaged public var requiresUpgrade: Bool
    @NSManaged public var typeRawValue: Int16
    @NSManaged public var configuration: Configuration?
    @NSManaged public var integrations: NSSet?
    @NSManaged public var server: Server?
    @NSManaged public var stats: Stats?

}

// MARK: Generated accessors for integrations
extension Bot {

    @objc(addIntegrationsObject:)
    @NSManaged public func addToIntegrations(_ value: Integration)

    @objc(removeIntegrationsObject:)
    @NSManaged public func removeFromIntegrations(_ value: Integration)

    @objc(addIntegrations:)
    @NSManaged public func addToIntegrations(_ values: NSSet)

    @objc(removeIntegrations:)
    @NSManaged public func removeFromIntegrations(_ values: NSSet)

}
#endif
