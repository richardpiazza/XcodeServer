import Foundation
#if canImport(CoreData)
import CoreData

@objc(Asset)
public class Asset: NSManagedObject {
    
    @NSManaged public var allowAnonymousAccess: Bool
    @NSManaged public var fileName: String?
    @NSManaged public var isDirectory: Bool
    @NSManaged public var relativePath: String?
    @NSManaged public var size: Int32
    @NSManaged public var triggerName: String?
    @NSManaged public var inverseArchive: IntegrationAssets?
    @NSManaged public var inverseBuildServiceLog: IntegrationAssets?
    @NSManaged public var inverseProduct: IntegrationAssets?
    @NSManaged public var inverseSourceControlLog: IntegrationAssets?
    @NSManaged public var inverseTriggerAssets: IntegrationAssets?
    @NSManaged public var inverseXcodebuildLog: IntegrationAssets?
    @NSManaged public var inverseXcodebuildOutput: IntegrationAssets?
    
}

#endif
