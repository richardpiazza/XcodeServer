import XcodeServer
#if canImport(CoreData)
import CoreData

public extension XcodeServerCoreData.Asset {
    func update(_ asset: XcodeServer.Integration.Asset) {
        allowAnonymousAccess = asset.allowAnonymousAccess
        isDirectory = asset.isDirectory
        fileName = asset.fileName
        relativePath = asset.relativePath
        size = Int32(asset.size)
        triggerName  = asset.triggerName
    }
}
#endif
