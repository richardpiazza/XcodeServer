import Foundation
#if canImport(CoreData)
import CoreData

/// An `Integration` asset
///
/// Each integration on your server generates a number of files, known as assets.
/// Assets include log files, Xcode archives and installable products like IPA or PKG files.
@objc(Asset)
public class Asset: NSManagedObject {
    
    public convenience init?(into context: NSManagedObjectContext) {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: type(of: self).entityName, in: context) else {
            return nil
        }
        
        self.init(entity: entityDescription, insertInto: context)
        self.allowAnonymousAccess = false
        self.isDirectory = false
        self.size = 0
    }
}

// MARK: - CoreData Properties
public extension Asset {
    
    @nonobjc class func fetchRequest() -> NSFetchRequest<Asset> {
        return NSFetchRequest<Asset>(entityName: entityName)
    }
    
    @NSManaged var allowAnonymousAccess: Bool
    @NSManaged var fileName: String?
    @NSManaged var isDirectory: Bool
    @NSManaged var relativePath: String?
    @NSManaged var size: Int32
    @NSManaged var triggerName: String?
    @NSManaged var inverseArchive: IntegrationAssets?
    @NSManaged var inverseBuildServiceLog: IntegrationAssets?
    @NSManaged var inverseProduct: IntegrationAssets?
    @NSManaged var inverseSourceControlLog: IntegrationAssets?
    @NSManaged var inverseTriggerAssets: IntegrationAssets?
    @NSManaged var inverseXcodebuildLog: IntegrationAssets?
    @NSManaged var inverseXcodebuildOutput: IntegrationAssets?
    
}

#endif
