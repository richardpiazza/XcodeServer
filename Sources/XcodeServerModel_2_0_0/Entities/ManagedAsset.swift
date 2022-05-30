import Foundation
import CoreDataPlus
import XcodeServer
#if canImport(CoreData)
import CoreData

public class ManagedAsset: NSManagedObject {

}

extension ManagedAsset {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedAsset> {
        return NSFetchRequest<ManagedAsset>(entityName: "ManagedAsset")
    }

    @NSManaged public var allowAnonymousAccess: Bool
    @NSManaged public var fileName: String?
    @NSManaged public var isDirectory: Bool
    @NSManaged public var relativePath: String?
    @NSManaged public var size: Int32
    @NSManaged public var triggerName: String?
    @NSManaged public var inverseArchive: ManagedIntegrationAssets?
    @NSManaged public var inverseBuildServiceLog: ManagedIntegrationAssets?
    @NSManaged public var inverseProduct: ManagedIntegrationAssets?
    @NSManaged public var inverseSourceControlLog: ManagedIntegrationAssets?
    @NSManaged public var inverseTriggerAssets: ManagedIntegrationAssets?
    @NSManaged public var inverseXcodebuildLog: ManagedIntegrationAssets?
    @NSManaged public var inverseXcodebuildOutput: ManagedIntegrationAssets?

}

extension ManagedAsset {
    func update(_ asset: Integration.Asset) {
        allowAnonymousAccess = asset.allowAnonymousAccess
        isDirectory = asset.isDirectory
        fileName = asset.fileName
        relativePath = asset.relativePath
        size = Int32(asset.size)
        triggerName  = asset.triggerName
    }
}

extension Integration.Asset {
    init(_ asset: ManagedAsset) {
        self.init()
        size = Int(asset.size)
        fileName = asset.fileName ?? ""
        relativePath = asset.relativePath ?? ""
        triggerName = asset.triggerName ?? ""
        allowAnonymousAccess = asset.allowAnonymousAccess
        isDirectory = asset.isDirectory
    }
}
#endif
