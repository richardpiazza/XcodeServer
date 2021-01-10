import XcodeServer
import XcodeServerCoreData
import Foundation
#if canImport(CoreData)
import CoreData

//@objc(Asset)
class Asset: NSManagedObject {

}

extension Asset {

    @nonobjc class func fetchRequest() -> NSFetchRequest<Asset> {
        return NSFetchRequest<Asset>(entityName: "Asset")
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

extension Asset {
    func update(_ asset: XcodeServer.Integration.Asset) {
        allowAnonymousAccess = asset.allowAnonymousAccess
        isDirectory = asset.isDirectory
        fileName = asset.fileName
        relativePath = asset.relativePath
        size = Int32(asset.size)
        triggerName  = asset.triggerName
    }
}

extension XcodeServer.Integration.Asset {
    init(_ asset: Asset) {
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
