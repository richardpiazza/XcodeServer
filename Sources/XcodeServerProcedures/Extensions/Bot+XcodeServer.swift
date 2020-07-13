import Foundation
import XcodeServerAPI
#if canImport(CoreData)
import XcodeServerCoreData

public extension Bot {
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
            self.configuration?.update(withConfiguration: configuration)
        }
        
        if let blueprint = bot.lastRevisionBlueprint {
            for id in blueprint.repositoryIds {
                if let repository = context.repository(withIdentifier: id) {
                    repository.update(withRevisionBlueprint: blueprint)
                    continue
                }
                
                if let repository = Repository(managedObjectContext: context, identifier: id) {
                    repository.update(withRevisionBlueprint: blueprint)
                }
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
            
            if let integration = Integration(managedObjectContext: context, identifier: element.id, bot: self) {
                events.append(.integration(action: .create, identifier: element.id, number: element.number))
                let integrationEvents = integration.update(withIntegration: element)
                events.append(contentsOf: integrationEvents)
            }
        }
        
        return events
    }
}

#endif
