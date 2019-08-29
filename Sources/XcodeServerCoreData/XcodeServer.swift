import Foundation
import CoreData
import XcodeServerAPI

/// An `XcodeServer` is one of the root elements in the object graph.
/// This represents a single Xcode Server, uniquely identified by its
/// FQDN (Fully Qualified Domain Name).
public class XcodeServer: NSManagedObject {
    
    public convenience init?(managedObjectContext: NSManagedObjectContext, fqdn: String) {
        self.init(managedObjectContext: managedObjectContext)
        self.fqdn = fqdn
    }
    
    public func update(withVersion version: XCSVersion, api: Int? = nil) {
        self.os = version.os
        self.server = version.server
        self.xcodeServer = version.xcodeServer
        self.xcode = version.xcode
        if let api = api {
            self.apiVersion = api as NSNumber
        }
    }
    
    public func update(withBots data: [XCSBot]) {
        guard let moc = self.managedObjectContext else {
            return
        }
        
        guard let bots = self.bots else {
            return
        }
        
        var ids: [String] = bots.map({ $0.identifier })
        
        for element in data {
            if let index = ids.firstIndex(of: element._id) {
                ids.remove(at: index)
            }
            
            if let bot = moc.bot(withIdentifier: element._id) {
                bot.update(withBot: element)
                continue
            }
            
            if let bot = Bot(managedObjectContext: moc, identifier: element._id, server: self) {
                bot.update(withBot: element)
            }
        }
        
        for id in ids {
            if let bot = moc.bot(withIdentifier: id) {
                bot.xcodeServer = nil
                moc.delete(bot)
            }
        }
    }
    
    /// The root API URL for this `XcodeServer`.
    /// Apple by default requires the HTTPS scheme and port 20343.
    public var apiURL: URL? {
        return URL(string: "https://\(self.fqdn):20343/api")
    }
}
