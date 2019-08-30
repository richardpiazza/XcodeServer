import Foundation
import CoreData

/// Represents an Xcode Server Bot.
///
/// Bots are processes that Xcode Server runs to perform integrations on the current version of a project in a source
/// code repository.
public class Bot: NSManagedObject {
    
    public convenience init?(managedObjectContext: NSManagedObjectContext, identifier: String, server: XcodeServer) {
        self.init(managedObjectContext: managedObjectContext)
        self.identifier = identifier
        self.xcodeServer = server
        self.integrations = Set<Integration>()
        self.configuration = Configuration(managedObjectContext: managedObjectContext, bot: self)
        self.stats = Stats(managedObjectContext: managedObjectContext, bot: self)
    }
}
