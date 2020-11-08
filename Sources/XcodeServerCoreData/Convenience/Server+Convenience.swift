import XcodeServer
#if canImport(CoreData)
import CoreData

public extension Server {
    /// The root API URL for this `XcodeServer`.
    /// Apple by default requires the HTTPS scheme and port 20343.
    var apiURL: URL? {
        return URL(string: "https://\(self.fqdn ?? ""):20343/api")
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
        update(server.bots, context: context)
    }
    
    /// Inserts or updates `Bot`s.
    ///
    /// - parameter entities: The entities to process
    /// - parameter context: The managed context in which to perform operations.
    func update(_ entities: Set<XcodeServer.Bot>, context: NSManagedObjectContext) {
        entities.forEach({ entity in
            let bot: Bot
            if let existing = context.bot(withIdentifier: entity.id) {
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
#endif
