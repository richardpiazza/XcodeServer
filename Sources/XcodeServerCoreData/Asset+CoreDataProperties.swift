import Foundation
import CoreData

public extension Asset {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Asset> {
        return NSFetchRequest<Asset>(entityName: "Asset")
    }
    
    @NSManaged public var allowAnonymousAccess: NSNumber?
    @NSManaged public var fileName: String?
    @NSManaged public var isDirectory: NSNumber?
    @NSManaged public var relativePath: String?
    @NSManaged public var size: NSNumber?
    @NSManaged public var triggerName: String?
    @NSManaged public var inverseArchive: IntegrationAssets?
    @NSManaged public var inverseBuildServiceLog: IntegrationAssets?
    @NSManaged public var inverseProduct: IntegrationAssets?
    @NSManaged public var inverseSourceControlLog: IntegrationAssets?
    @NSManaged public var inverseTriggerAssets: IntegrationAssets?
    @NSManaged public var inverseXcodebuildLog: IntegrationAssets?
    @NSManaged public var inverseXcodebuildOutput: IntegrationAssets?
    
}
