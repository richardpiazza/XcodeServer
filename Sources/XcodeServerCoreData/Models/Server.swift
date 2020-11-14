import Foundation
#if canImport(CoreData)
import CoreData

@objc(Server)
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
#endif
