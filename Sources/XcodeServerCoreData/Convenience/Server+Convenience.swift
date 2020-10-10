import XcodeServer
#if canImport(CoreData)
import CoreData

public extension Server {
    /// The root API URL for this `XcodeServer`.
    /// Apple by default requires the HTTPS scheme and port 20343.
    var apiURL: URL? {
        return URL(string: "https://\(self.fqdn):20343/api")
    }
}

public extension XcodeServerCoreData.Server {
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
        update(Array(server.bots), context: context)
    }
    
    /// Inserts or updates `Bot`s.
    ///
    /// - parameter entities: The entities to process
    /// - parameter context: The managed context in which to perform operations.
    func update(_ entities: [XcodeServer.Bot], context: NSManagedObjectContext) {
        entities.forEach({ entity in
            if let existing = bots?.first(where: { $0.identifier == entity.id }) {
                existing.update(entity, context: context)
            } else {
                let new = Bot(context: context)
                new.update(entity, context: context)
                addToBots(new)
            }
        })
    }
}

/*
 public extension XcodeServerCoreData.Server {
     func update(withVersion version: XCSVersion, api: Int? = nil) {
         self.os = version.macOSVersion
         self.server = version.serverAppVersion
         self.xcodeServer = version.xcodeServerVersion
         self.xcode = version.xcodeAppVersion
         if let api = api {
             self.apiVersion = Int32(api)
         }
     }
     
     @discardableResult
     func update(withBots data: [XCSBot]) -> [XcodeServerProcedureEvent] {
         var events: [XcodeServerProcedureEvent] = []
         
         guard let context = self.managedObjectContext else {
             return events
         }
         
         guard let bots = self.bots else {
             return events
         }
         
         var ids: [String] = bots.compactMap({ $0.identifier })
         
         for element in data {
             if let index = ids.firstIndex(of: element.id) {
                 ids.remove(at: index)
             }
             
             if let bot = context.bot(withIdentifier: element.id) {
                 let botEvents = bot.update(withBot: element)
                 events.append(contentsOf: botEvents)
                 continue
             }
             
             let bot = Bot(context: context)
             bot.identifier = element.id
             bot.server = self
             events.append(.bot(action: .create, identifier: element.id, name: element.name))
             let botEvents = bot.update(withBot: element)
             events.append(contentsOf: botEvents)
         }
         
         for id in ids {
             if let bot = context.bot(withIdentifier: id) {
                 events.append(.bot(action: .delete, identifier: bot.identifier, name: bot.name ?? ""))
                 bot.server = nil
                 context.delete(bot)
             }
         }
         
         return events
     }
 }
 */

#endif
