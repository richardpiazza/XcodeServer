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
            configuration = Configuration(context: context)
        }
        if stats == nil {
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
    }
    
    /// Inserts or updates `Integration`s.
    ///
    /// `Integration`s will not be removed if not present.
    ///
    /// - parameter entities: The integrations to process.
    /// - parameter dropReferences: Removes entities not referenced in the update.
    /// - parameter context: The current managed object context for performing operations.
    func update(_ entities: [XcodeServer.Integration], dropReferences: Bool = false, context: NSManagedObjectContext) {
        if dropReferences {
            let ids = entities.map { $0.id }
            let droppedEntities = integrations?.filter({ !ids.contains($0.identifier) }) ?? []
            removeFromIntegrations(Set(droppedEntities))
        }
        
        entities.forEach({ integration in
            if let existing = integrations?.first(where: { $0.identifier == integration.id }) {
                existing.update(integration, context: context)
            } else {
                let new = Integration(context: context)
                new.update(integration, context: context)
                addToIntegrations(new)
            }
        })
    }
}

/*
 public extension XcodeServerCoreData.Bot {
     @discardableResult
     func update(withBot bot: XCSBot) -> [XcodeServerProcedureEvent] {
         var events: [XcodeServerProcedureEvent] = []
         
         guard let context = self.managedObjectContext else {
             return events
         }
         
         if (integrationCounter != bot.nextIntegrationNumber) || (requiresUpgrade != bot.requiresUpgrade) {
             events.append(.bot(action: .update, identifier: bot.id, name: bot.name))
         }
         
         self.integrationCounter = Int32(bot.nextIntegrationNumber)
         self.name = bot.name
         self.typeRawValue = Int16(bot.type)
         self.requiresUpgrade = bot.requiresUpgrade
         
         if let configuration = bot.configuration {
             if self.configuration == nil {
                 self.configuration = Configuration(context: context)
             }
             
             self.configuration?.update(withConfiguration: configuration)
         }
         
         if let blueprint = bot.lastRevisionBlueprint {
             for id in blueprint.repositoryIds {
                 if let repository = context.repository(withIdentifier: id) {
                     repository.update(withRevisionBlueprint: blueprint)
                     continue
                 }
                 
                 let repository = Repository(context: context)
                 repository.identifier = id
                 repository.update(withRevisionBlueprint: blueprint)
             }
         }
         
         return events
     }
     
     @discardableResult
     func update(withIntegrations integrations: [XCSIntegration]) -> [XcodeServerProcedureEvent] {
         var events: [XcodeServerProcedureEvent] = []
         
         guard let context = self.managedObjectContext else {
             return events
         }
         
         for element in integrations {
             if let integration = context.integration(withIdentifier: element.id) {
                 let integrationEvents = integration.update(withIntegration: element)
                 events.append(contentsOf: integrationEvents)
                 continue
             }
             
             let integration = Integration(context: context)
             integration.identifier = element.id
             integration.bot = self
             events.append(.integration(action: .create, identifier: element.id, number: element.number))
             let integrationEvents = integration.update(withIntegration: element)
             events.append(contentsOf: integrationEvents)
         }
         
         return events
     }
 }
 */

#endif
