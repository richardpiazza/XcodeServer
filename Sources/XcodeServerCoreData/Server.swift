import Foundation
#if canImport(CoreData)
import CoreData

/// An `XcodeServer` is one of the root elements in the object graph.
/// This represents a single Xcode Server, uniquely identified by its
/// FQDN (Fully Qualified Domain Name).
@objc(Server)
public class Server: NSManagedObject {
    
    public convenience init?(managedObjectContext: NSManagedObjectContext, fqdn: String) {
        self.init(managedObjectContext: managedObjectContext)
        self.fqdn = fqdn
        self.apiVersion = 0
    }
    
}

// MARK: - CoreData Properties
public extension Server {
    
    @nonobjc class func fetchRequest() -> NSFetchRequest<Server> {
        return NSFetchRequest<Server>(entityName: entityName)
    }
    
    @NSManaged var fqdn: String
    @NSManaged var lastUpdate: Date?
    @NSManaged var os: String?
    @NSManaged var server: String?
    @NSManaged var xcode: String?
    @NSManaged var xcodeServer: String?
    @NSManaged var apiVersion: Int32
    @NSManaged var bots: Set<Bot>?
    
}

// MARK: Generated accessors for bots
extension Server {
    
    @objc(addBotsObject:)
    @NSManaged public func addToBots(_ value: Bot)
    
    @objc(removeBotsObject:)
    @NSManaged public func removeFromBots(_ value: Bot)
    
    @objc(addBots:)
    @NSManaged public func addToBots(_ values: Set<Bot>)
    
    @objc(removeBots:)
    @NSManaged public func removeFromBots(_ values: Set<Bot>)
    
}

public extension Server {
    /// The root API URL for this `XcodeServer`.
    /// Apple by default requires the HTTPS scheme and port 20343.
    var apiURL: URL? {
        return URL(string: "https://\(self.fqdn):20343/api")
    }
}

#endif
