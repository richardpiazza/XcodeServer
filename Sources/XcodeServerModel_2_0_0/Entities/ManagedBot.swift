import Foundation
import CoreDataPlus
import XcodeServer
#if canImport(CoreData)
import CoreData

public class ManagedBot: NSManagedObject {

}

extension ManagedBot {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedBot> {
        return NSFetchRequest<ManagedBot>(entityName: "ManagedBot")
    }

    @NSManaged public var identifier: String?
    @NSManaged public var integrationCounter: Int32
    @NSManaged public var lastUpdate: Date?
    @NSManaged public var name: String?
    @NSManaged public var requiresUpgrade: Bool
    @NSManaged public var typeRawValue: Int16
    @NSManaged public var configuration: ManagedConfiguration?
    @NSManaged public var integrations: NSSet?
    @NSManaged public var server: ManagedServer?
    @NSManaged public var stats: ManagedStats?

}

// MARK: Generated accessors for integrations
extension ManagedBot {

    @objc(addIntegrationsObject:)
    @NSManaged public func addToIntegrations(_ value: ManagedIntegration)

    @objc(removeIntegrationsObject:)
    @NSManaged public func removeFromIntegrations(_ value: ManagedIntegration)

    @objc(addIntegrations:)
    @NSManaged public func addToIntegrations(_ values: NSSet)

    @objc(removeIntegrations:)
    @NSManaged public func removeFromIntegrations(_ values: NSSet)

}

extension ManagedBot {
    static func fetchBots() -> NSFetchRequest<ManagedBot> {
        fetchRequest()
    }
    
    static func fetchBots(forServer id: Server.ID) -> NSFetchRequest<ManagedBot> {
        let request = fetchRequest()
        request.predicate = NSPredicate(format: "%K = %@", #keyPath(ManagedBot.server.fqdn), id)
        return request
    }
    
    static func fetchBot(withId id: Bot.ID) -> NSFetchRequest<ManagedBot> {
        let request = fetchRequest()
        request.predicate = NSPredicate(format: "%K = %@", #keyPath(ManagedBot.identifier), id)
        return request
    }
    
    /// Retrieves the first `ManagedBot` entity from the Core Data `NSManagedObjectContext` that matches the specified identifier.
    static func bot(_ id: Bot.ID, in context: NSManagedObjectContext) -> ManagedBot? {
        let request = NSFetchRequest<ManagedBot>(entityName: entityName)
        request.predicate = NSPredicate(format: "identifier = %@", argumentArray: [id])
        do {
            return try context.fetch(request).first
        } catch {
            PersistentContainer.logger.error("", metadata: ["localizedDescription": .string(error.localizedDescription)])
        }
        
        return nil
    }
}

extension ManagedBot {
    /// Update the `Bot`, creating relationships as needed.
    ///
    /// - parameter bot: The bot with attributes to use for updates.
    /// - parameter context: The current managed object context for performing operations.
    func update(_ bot: Bot, context: NSManagedObjectContext) {
        if configuration == nil {
            PersistentContainer.logger.info("Creating CONFIGURATION for Bot '\(bot.name)' [\(bot.id)]")
            configuration = context.make()
        }
        if stats == nil {
            PersistentContainer.logger.info("Creating STATS for Bot '\(bot.name)' [\(bot.id)]")
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
                let repository: ManagedRepository
                if let entity = ManagedRepository.repository(remoteId, in: context) {
                    repository = entity
                } else {
                    PersistentContainer.logger.info("Creating REPOSITORY '\(blueprint.name)' [\(remoteId)]")
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
    func update(_ entities: [Integration], context: NSManagedObjectContext) {
        entities.forEach({ integration in
            if let existing = (integrations as? Set<ManagedIntegration>)?.first(where: { $0.identifier == integration.id }) {
                existing.update(integration, context: context)
            } else {
                PersistentContainer.logger.info("Creating INTEGRATION '\(integration.number)' [\(integration.id)] for Bot '\(name ?? "")'")
                let new: ManagedIntegration = context.make()
                new.update(integration, context: context)
                addToIntegrations(new)
            }
        })
    }
}

extension Bot {
    init(_ bot: ManagedBot) {
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
        if let integrations = bot.integrations as? Set<ManagedIntegration> {
            self.integrations = Set(integrations.map { Integration($0) })
        }
    }
}
#endif
