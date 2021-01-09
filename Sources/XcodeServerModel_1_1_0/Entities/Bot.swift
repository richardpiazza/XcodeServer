import XcodeServer
import XcodeServerCoreData
import Foundation
#if canImport(CoreData)
import CoreData

//@objc(Bot)
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

public extension Bot {
    /// Retrieves all `Bot` entities from the Core Data `NSManagedObjectContext`
    static func bots(in context: NSManagedObjectContext) -> [Bot] {
        let request = NSFetchRequest<Bot>(entityName: Bot.entityName)
        do {
            return try context.fetch(request)
        } catch {
            InternalLog.coreData.error("Failed to fetch bots", error: error)
        }
        
        return []
    }
    
    /// Retrieves all `Bot` entities for a specific `Server`.
    static func bots(forServer id: XcodeServer.Server.ID, in context: NSManagedObjectContext) -> [Bot] {
        let request = NSFetchRequest<Bot>(entityName: entityName)
        request.predicate = NSPredicate(format: "server.fqdn = %@", argumentArray: [id])
        do {
            return try context.fetch(request)
        } catch {
            InternalLog.coreData.error("Failed to fetch bots for server \(id)", error: error)
        }
        
        return []
    }
    
    /// Retrieves the first `Bot` entity from the Core Data `NSManagedObjectContext` that matches the specified
    /// identifier.
    static func bot(_ id: XcodeServer.Bot.ID, in context: NSManagedObjectContext) -> Bot? {
        let request = NSFetchRequest<Bot>(entityName: entityName)
        request.predicate = NSPredicate(format: "identifier = %@", argumentArray: [id])
        do {
            return try context.fetch(request).first
        } catch {
            InternalLog.coreData.error("", error: error)
        }
        
        return nil
    }
}

public extension Bot {
    /// Update the `Bot`, creating relationships as needed.
    ///
    /// - parameter bot: The bot with attributes to use for updates.
    /// - parameter context: The current managed object context for performing operations.
    func update(_ bot: XcodeServer.Bot, context: NSManagedObjectContext) {
        if configuration == nil {
            InternalLog.coreData.debug("Creating CONFIGURATION for Bot '\(bot.name)' [\(bot.id)]")
            configuration = context.make()
        }
        if stats == nil {
            InternalLog.coreData.debug("Creating STATS for Bot '\(bot.name)' [\(bot.id)]")
            stats = context.make()
        }
        
        configuration?.update(bot.configuration, context: context)
        identifier = bot.id
        integrationCounter = Int32(bot.nextIntegrationNumber)
        lastUpdate = bot.modified
        name = bot.name
        requiresUpgrade = bot.requiresUpgrade
        stats?.update(bot.stats, context: context)
        typeRawValue = Int16(bot.type)
        update(Array(bot.integrations), context: context)
        
        if let blueprint = bot.lastRevisionBlueprint {
            let remoteId = blueprint.primaryRemoteIdentifier
            if !remoteId.isEmpty {
                let repository: Repository
                if let entity = Repository.repository(remoteId, in: context) {
                    repository = entity
                } else {
                    InternalLog.coreData.debug("Creating REPOSITORY '\(blueprint.name)' [\(remoteId)]")
                    repository = context.make()
                }
                repository.update(blueprint, context: context)
            }
        }
    }
    
    /// Inserts or updates `Integration`s.
    ///
    /// `Integration`s will not be removed if not present.
    ///
    /// - parameter entities: The integrations to process.
    /// - parameter context: The current managed object context for performing operations.
    func update(_ entities: [XcodeServer.Integration], context: NSManagedObjectContext) {
        entities.forEach({ integration in
            if let existing = (integrations as? Set<Integration>)?.first(where: { $0.identifier == integration.id }) {
                existing.update(integration, context: context)
            } else {
                InternalLog.coreData.debug("Creating INTEGRATION '\(integration.number)' [\(integration.id)] for Bot '\(name ?? "")'")
                let new: Integration = context.make()
                new.update(integration, context: context)
                addToIntegrations(new)
            }
        })
    }
}

public extension XcodeServer.Bot {
    init(_ bot: Bot) {
        self.init(id: bot.identifier ?? "")
        modified = bot.lastUpdate ?? Date()
        name = bot.name ?? ""
        nextIntegrationNumber = Int(bot.integrationCounter)
        type = Int(bot.typeRawValue)
        requiresUpgrade = bot.requiresUpgrade
        serverId = bot.server?.fqdn
        if let config = bot.configuration {
            configuration = Configuration(config)
        }
        if let stats = bot.stats {
            self.stats = Stats(stats)
        }
        if let integrations = bot.integrations as? Set<Integration> {
            self.integrations = Set(integrations.map { XcodeServer.Integration($0) })
        }
    }
}
#endif
