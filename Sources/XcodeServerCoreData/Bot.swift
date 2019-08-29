import Foundation
import CoreData
import XcodeServerAPI

/// ## Bot
/// Represents an Xcode Server Bot.
/// "Bots are processes that Xcode Server runs to perform integrations on the current version of a project in a source code repository."
public class Bot: NSManagedObject {
    
    public convenience init?(managedObjectContext: NSManagedObjectContext, identifier: String, server: XcodeServer) {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "Bot", in: managedObjectContext) else {
            return nil
        }
        
        self.init(entity: entityDescription, insertInto: managedObjectContext)
        self.identifier = identifier
        self.xcodeServer = server
        self.integrations = Set<Integration>()
        self.configuration = Configuration(managedObjectContext: managedObjectContext, bot: self)
        self.stats = Stats(managedObjectContext: managedObjectContext, bot: self)
    }
    
    public func update(withBot bot: XCSBot) {
        guard let moc = self.managedObjectContext else {
            return
        }
        
        self.revision = bot._rev
        self.name = bot.name
        self.type = bot.type as NSNumber?
        
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
    
    public func update(withIntegrations integrations: [XCSIntegration]) {
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
