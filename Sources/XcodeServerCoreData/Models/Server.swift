import Foundation
#if canImport(CoreData)
import CoreData

@objc(Server)
public class Server: NSManagedObject {
    
    @NSManaged public var fqdn: String
    @NSManaged public var lastUpdate: Date?
    @NSManaged public var os: String?
    @NSManaged public var server: String?
    @NSManaged public var xcode: String?
    @NSManaged public var xcodeServer: String?
    @NSManaged public var apiVersion: Int32
    @NSManaged public var bots: Set<Bot>?
    
    @objc(addBotsObject:)
    @NSManaged public func addToBots(_ value: Bot)
    
    @objc(removeBotsObject:)
    @NSManaged public func removeFromBots(_ value: Bot)
    
    @objc(addBots:)
    @NSManaged public func addToBots(_ values: Set<Bot>)
    
    @objc(removeBots:)
    @NSManaged public func removeFromBots(_ values: Set<Bot>)
    
}

#endif
