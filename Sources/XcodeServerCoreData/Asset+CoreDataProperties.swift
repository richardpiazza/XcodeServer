import Foundation
import CoreData

public extension Asset {
    
    @nonobjc class func fetchRequest() -> NSFetchRequest<Asset> {
        return NSFetchRequest<Asset>(entityName: "Asset")
    }
    
    @NSManaged var allowAnonymousAccess: NSNumber?
    @NSManaged var fileName: String?
    @NSManaged var isDirectory: NSNumber?
    @NSManaged var relativePath: String?
    @NSManaged var size: NSNumber?
    @NSManaged var triggerName: String?
    @NSManaged var inverseArchive: IntegrationAssets?
    @NSManaged var inverseBuildServiceLog: IntegrationAssets?
    @NSManaged var inverseProduct: IntegrationAssets?
    @NSManaged var inverseSourceControlLog: IntegrationAssets?
    @NSManaged var inverseTriggerAssets: IntegrationAssets?
    @NSManaged var inverseXcodebuildLog: IntegrationAssets?
    @NSManaged var inverseXcodebuildOutput: IntegrationAssets?
    
}
