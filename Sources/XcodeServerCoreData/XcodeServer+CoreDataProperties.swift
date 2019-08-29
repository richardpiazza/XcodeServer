import Foundation
import CoreData

extension XcodeServer {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<XcodeServer> {
        return NSFetchRequest<XcodeServer>(entityName: "XcodeServer")
    }
    
    @NSManaged public var fqdn: String
    @NSManaged public var lastUpdate: Date?
    @NSManaged public var os: String?
    @NSManaged public var server: String?
    @NSManaged public var xcode: String?
    @NSManaged public var xcodeServer: String?
    @NSManaged public var apiVersion: NSNumber?
    @NSManaged public var bots: Set<Bot>?
    
}

// MARK: Generated accessors for bots
extension XcodeServer {
    
    @objc(addBotsObject:)
    @NSManaged public func addToBots(_ value: Bot)
    
    @objc(removeBotsObject:)
    @NSManaged public func removeFromBots(_ value: Bot)
    
    @objc(addBots:)
    @NSManaged public func addToBots(_ values: Set<Bot>)
    
    @objc(removeBots:)
    @NSManaged public func removeFromBots(_ values: Set<Bot>)
    
}
