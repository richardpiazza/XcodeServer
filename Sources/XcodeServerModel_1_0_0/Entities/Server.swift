import XcodeServer
import XcodeServerCoreData
import Foundation
#if canImport(CoreData)
import CoreData

//@objc(Server)
public class Server: NSManagedObject {

}

extension Server {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Server> {
        return NSFetchRequest<Server>(entityName: "Server")
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
extension Server {

    @objc(addBotsObject:)
    @NSManaged public func addToBots(_ value: Bot)

    @objc(removeBotsObject:)
    @NSManaged public func removeFromBots(_ value: Bot)

    @objc(addBots:)
    @NSManaged public func addToBots(_ values: NSSet)

    @objc(removeBots:)
    @NSManaged public func removeFromBots(_ values: NSSet)

}

extension Server {
    /// Retrieves all `Server` entities from the Core Data `NSManagedObjectContext`
    static func servers(in context: NSManagedObjectContext) -> [Server] {
        let request = NSFetchRequest<Server>(entityName: entityName)
        do {
            return try context.fetch(request)
        } catch {
            InternalLog.coreData.error("Failed to fetch servers", error: error)
        }
        
        return []
    }
    
    /// Retrieves the first `Server` entity from the Core Data `NSManagedObjectContext` that matches the specified id.
    static func server(_ id: XcodeServer.Server.ID, in context: NSManagedObjectContext) -> Server? {
        let request = NSFetchRequest<Server>(entityName: entityName)
        request.predicate = NSPredicate(format: "fqdn = %@", argumentArray: [id])
        do {
            return try context.fetch(request).first
        } catch {
            InternalLog.coreData.error("Failed to fetch server '\(id)'", error: error)
        }
        
        return nil
    }
    
    static func serversLastUpdatedOnOrBefore(_ date: Date, in context: NSManagedObjectContext) -> [Server] {
        let request = NSFetchRequest<Server>(entityName: entityName)
        request.predicate = NSPredicate(format: "lastUpdate == nil OR lastUpdate < %@", argumentArray: [date])
        do {
            return try context.fetch(request)
        } catch {
            InternalLog.coreData.error("Failed to fetch server last updated", error: error)
        }
        
        return []
    }
}

public extension Server {
    /// The root API URL for this `XcodeServer`.
    /// Apple by default requires the HTTPS scheme and port 20343.
    var apiURL: URL? {
        return URL(string: "https://\(self.fqdn ?? ""):20343/api")
    }
}

public extension Server {
    /// Update the `Server`, creating relationships as needed.
    ///
    /// - parameter server: The entity with attributes to use for updates.
    /// - parameter context: The managed context in which to perform operations.
    func update(_ server: XcodeServer.Server, context: NSManagedObjectContext) {
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
    func update(_ entities: Set<XcodeServer.Bot>, context: NSManagedObjectContext) {
        entities.forEach({ entity in
            let bot: Bot
            if let existing = Bot.bot(entity.id, in: context) {
                bot = existing
            } else {
                bot = context.make()
                addToBots(bot)
                InternalLog.coreData.debug("Creating BOT '\(bot.name ?? "")' [\(bot.identifier ?? "")] for Server \(fqdn ?? "")")
            }
            
            bot.update(entity, context: context)
        })
    }
}

public extension XcodeServer.Server {
    /// Map `XcodeServerCoreData.Server` to `XcodeServe.Server`.
    ///
    /// - parameter server: The managed entity to transform.
    init(_ server: Server) {
        self.init(id: server.fqdn ?? "")
        modified = server.lastUpdate ?? Date()
        version = Version(server)
        if let bots = server.bots as? Set<Bot> {
            self.bots = Set(bots.map { XcodeServer.Bot($0) })
        }
    }
}

public extension XcodeServer.Server.Version {
    init(_ server: Server) {
        self.init()
        api = XcodeServer.Server.API(rawValue: Int(server.apiVersion)) ?? .v19
        app = XcodeServer.Server.App(rawValue: server.xcodeServer ?? "") ?? .v2_0
        macOSVersion = server.os ?? ""
        xcodeAppVersion = server.xcode ?? ""
        serverAppVersion = server.server ?? ""
    }
}
#endif
