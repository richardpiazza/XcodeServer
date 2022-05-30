import Foundation
import CoreDataPlus
import XcodeServer
#if canImport(CoreData)
import CoreData

public class ManagedServer: NSManagedObject {

}

extension ManagedServer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedServer> {
        return NSFetchRequest<ManagedServer>(entityName: "ManagedServer")
    }

    @NSManaged public var apiVersion: Int32
    @NSManaged public var fqdn: String?
    @NSManaged public var lastUpdate: Date?
    @NSManaged public var os: String?
    @NSManaged public var server: String?
    @NSManaged public var xcode: String?
    @NSManaged public var xcodeServer: String?
    @NSManaged public var bots: NSSet?

}

// MARK: Generated accessors for bots
extension ManagedServer {

    @objc(addBotsObject:)
    @NSManaged public func addToBots(_ value: ManagedBot)

    @objc(removeBotsObject:)
    @NSManaged public func removeFromBots(_ value: ManagedBot)

    @objc(addBots:)
    @NSManaged public func addToBots(_ values: NSSet)

    @objc(removeBots:)
    @NSManaged public func removeFromBots(_ values: NSSet)

}

extension ManagedServer {
    static func fetchServers() -> NSFetchRequest<ManagedServer> {
        fetchRequest()
    }
    
    static func fetchServers(lastUpdatedOnOrBefore date: Date) -> NSFetchRequest<ManagedServer> {
        let request = fetchRequest()
        request.predicate = NSCompoundPredicate(orPredicateWithSubpredicates: [
            NSPredicate(format: "%K == nil", #keyPath(ManagedServer.lastUpdate)),
            NSPredicate(format: "%K < %@", #keyPath(ManagedServer.lastUpdate), date as NSDate)
        ])
        return request
    }
    
    static func fetchServer(withId id: Server.ID) -> NSFetchRequest<ManagedServer> {
        let request = fetchRequest()
        request.predicate = NSPredicate(format: "%K = %@", #keyPath(ManagedServer.fqdn), id)
        return request
    }
    
    /// Retrieves the first `ManagedServer` entity from the Core Data `NSManagedObjectContext` that matches the specified id.
    static func server(_ id: Server.ID, in context: NSManagedObjectContext) -> ManagedServer? {
        let request = fetchRequest()
        request.predicate = NSPredicate(format: "$K = %@", #keyPath(ManagedServer.fqdn), id)
        do {
            return try context.fetch(request).first
        } catch {
            PersistentContainer.logger.error("Failed to fetch `ManagedServer`.", metadata: [
                "Server.ID": .string(id),
                "localizedDescription": .string(error.localizedDescription)
            ])
        }
        
        return nil
    }
    
    /// The root API URL for this `XcodeServer`.
    /// Apple by default requires the HTTPS scheme and port 20343.
    var apiURL: URL? {
        return URL(string: "https://\(fqdn ?? ""):20343/api")
    }
    
    /// Update the `Server`, creating relationships as needed.
    ///
    /// - parameter server: The entity with attributes to use for updates.
    /// - parameter context: The managed context in which to perform operations.
    func update(_ server: Server, context: NSManagedObjectContext) {
        fqdn = server.id
        lastUpdate = Date()
        apiVersion = Int32(server.version.api.rawValue)
        xcodeServer = server.version.app.rawValue
        if !server.version.macOSVersion.isEmpty {
            os = server.version.macOSVersion
        }
        if !server.version.xcodeAppVersion.isEmpty {
            xcode = server.version.xcodeAppVersion
        }
        if !server.version.serverAppVersion.isEmpty {
            self.server = server.version.serverAppVersion
        }
        update(server.bots, context: context)
    }
    
    /// Inserts or updates `Bot`s.
    ///
    /// - parameter entities: The entities to process
    /// - parameter context: The managed context in which to perform operations.
    func update(_ entities: Set<Bot>, context: NSManagedObjectContext) {
        entities.forEach({ entity in
            let bot: ManagedBot
            if let existing = ManagedBot.bot(entity.id, in: context) {
                bot = existing
            } else {
                bot = context.make()
                addToBots(bot)
                PersistentContainer.logger.trace("Creating `ManagedBot`.", metadata: [
                    "Bot.ID": .string(bot.identifier ?? ""),
                    "Bot.Name": .string(bot.name ?? ""),
                    "Server.ID": .string(fqdn ?? "")
                ])
            }
            
            bot.update(entity, context: context)
        })
    }
}

extension Server {
    init(_ server: ManagedServer) {
        self.init(id: server.fqdn ?? "")
        modified = server.lastUpdate ?? Date()
        version = Server.Version(server)
        if let bots = server.bots as? Set<ManagedBot> {
            self.bots = Set(bots.map { Bot($0) })
        }
    }
}

extension Server.Version {
    init(_ server: ManagedServer) {
        self.init()
        api = Server.API(rawValue: Int(server.apiVersion)) ?? .v19
        app = Server.App(rawValue: server.xcodeServer ?? "") ?? .v2_0
        macOSVersion = server.os ?? ""
        xcodeAppVersion = server.xcode ?? ""
        serverAppVersion = server.server ?? ""
    }
}
#endif
