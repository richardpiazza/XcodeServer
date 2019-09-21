import Foundation
import XcodeServerAPI
#if canImport(CoreData)
import XcodeServerCoreData

public extension Bot {
    @discardableResult
    func update(withBot bot: XCSBot) -> [XcodeServerProcedureEvent] {
        var events: [XcodeServerProcedureEvent] = []
        
        guard let moc = self.managedObjectContext else {
            return events
        }
        
        if (integrationCounter != bot.integrationCounter) || (requiresUpgrade != bot.requiresUpgrade) {
            events.append(.bot(action: .update, identifier: identifier, name: name ?? ""))
        }
        
        self.integrationCounter = bot.integrationCounter
        self.name = bot.name
        self.typeRawValue = bot.typeRawValue
        self.requiresUpgrade = bot.requiresUpgrade
        
        if let configuration = bot.configuration {
            self.configuration?.update(withConfiguration: configuration)
        }
        
        if let blueprint = bot.lastRevisionBlueprint {
            for id in blueprint.repositoryIds {
                if let repository = moc.repository(withIdentifier: id) {
                    repository.update(withRevisionBlueprint: blueprint)
                    continue
                }
                
                if let repository = Repository(managedObjectContext: moc, identifier: id) {
                    repository.update(withRevisionBlueprint: blueprint)
                }
            }
        }
        
        return events
    }
    
    @discardableResult
    func update(withIntegrations integrations: [XCSIntegration]) -> [XcodeServerProcedureEvent] {
        var events: [XcodeServerProcedureEvent] = []
        
        guard let moc = self.managedObjectContext else {
            return events
        }
        
        for element in integrations {
            if let integration = moc.integration(withIdentifier: element.identifier) {
                let integrationEvents = integration.update(withIntegration: element)
                events.append(contentsOf: integrationEvents)
                continue
            }
            
            if let integration = Integration(managedObjectContext: moc, identifier: element.identifier, bot: self) {
                events.append(.integration(action: .create, identifier: element.identifier, number: element.number))
                let integrationEvents = integration.update(withIntegration: element)
                events.append(contentsOf: integrationEvents)
            }
        }
        
        return events
    }
}

#endif
