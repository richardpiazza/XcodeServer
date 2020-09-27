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

/*
 extension XcodeServerCoreData.Asset {
     func update(withAsset asset: XCSIntegrationAsset) {
         self.allowAnonymousAccess = asset.allowAnonymousAccess ?? false
         self.isDirectory = asset.isDirectory ?? false
         self.fileName = asset.fileName
         self.relativePath = asset.relativePath
         self.size = (asset.size != nil) ? Int32(asset.size!) : 0
         self.triggerName = asset.triggerName
     }
 }
 */

#endif
