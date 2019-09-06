import Foundation
import XcodeServerAPI
import XcodeServerCoreData

public extension Bot {
    func update(withBot bot: XCSBot) {
        guard let moc = self.managedObjectContext else {
            return
        }
        
        self.name = bot.name
        self.botType = bot.typeRawValue
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
    }
    
    func update(withIntegrations integrations: [XCSIntegration]) {
        guard let moc = self.managedObjectContext else {
            return
        }
        
        for element in integrations {
            if let integration = moc.integration(withIdentifier: element._id) {
                integration.update(withIntegration: element)
                continue
            }
            
            if let integration = Integration(managedObjectContext: moc, identifier: element._id, bot: self) {
                integration.update(withIntegration: element)
            }
        }
    }
}