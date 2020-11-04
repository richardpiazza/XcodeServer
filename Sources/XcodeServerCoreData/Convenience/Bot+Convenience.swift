import XcodeServer
#if canImport(CoreData)
import CoreData

public extension XcodeServerCoreData.Bot {
    /// Update the `Bot`, creating relationships as needed.
    ///
    /// - parameter bot: The bot with attributes to use for updates.
    /// - parameter context: The current managed object context for performing operations.
    func update(_ bot: XcodeServer.Bot, context: NSManagedObjectContext) {
        if configuration == nil {
            InternalLog.coreData.info("Creating CONFIGURATION for Bot '\(bot.name)' [\(bot.id)]")
            configuration = Configuration(context: context)
        }
        if stats == nil {
            InternalLog.coreData.info("Creating STATS for Bot '\(bot.name)' [\(bot.id)]")
            stats = Stats(context: context)
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
                if let entity = context.repository(withIdentifier: remoteId) {
                    repository = entity
                } else {
                    InternalLog.coreData.info("Creating REPOSITORY '\(blueprint.name)' [\(remoteId)]")
                    repository = Repository(context: context)
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
            if let existing = (integrations as? Set<XcodeServerCoreData.Integration>)?.first(where: { $0.identifier == integration.id }) {
                existing.update(integration, context: context)
            } else {
                InternalLog.coreData.info("Creating INTEGRATION '\(integration.number)' [\(integration.id)] for Bot '\(name ?? "")'")
                let new = Integration(context: context)
                new.update(integration, context: context)
                addToIntegrations(new)
            }
        })
    }
}
#endif
