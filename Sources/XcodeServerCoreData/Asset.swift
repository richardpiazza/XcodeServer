import Foundation
import CoreData

/// An `Integration` asset
///
/// Each integration on your server generates a number of files, known as assets.
/// Assets include log files, Xcode archives and installable products like IPA or PKG files.
public class Asset: NSManagedObject {
    
}

// MARK: - CoreData Properties
public extension Asset {
    
    @nonobjc class func fetchRequest() -> NSFetchRequest<Asset> {
        return NSFetchRequest<Asset>(entityName: entityName)
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
