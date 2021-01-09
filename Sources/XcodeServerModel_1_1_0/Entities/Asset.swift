import XcodeServer
import XcodeServerCoreData
import Foundation
#if canImport(CoreData)
import CoreData

//@objc(Asset)
public class Asset: NSManagedObject {

}

extension Asset {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Asset> {
        return NSFetchRequest<Asset>(entityName: "Asset")
    }

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

public extension Asset {
    func update(_ asset: XcodeServer.Integration.Asset) {
        allowAnonymousAccess = asset.allowAnonymousAccess
        isDirectory = asset.isDirectory
        fileName = asset.fileName
        relativePath = asset.relativePath
        size = Int32(asset.size)
        triggerName  = asset.triggerName
    }
}

public extension XcodeServer.Integration.Asset {
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
