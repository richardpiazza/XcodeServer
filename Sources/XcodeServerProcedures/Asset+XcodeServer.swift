import Foundation
import XcodeServerAPI
import XcodeServerCoreData

extension Asset {
    func update(withAsset asset: XCSIntegrationAsset) {
        self.allowAnonymousAccess = asset.allowAnonymousAccess ?? false
        self.isDirectory = asset.isDirectory ?? false
        self.fileName = asset.fileName
        self.relativePath = asset.relativePath
        self.size = (asset.size != nil) ? Int32(asset.size!) : 0
        self.triggerName = asset.triggerName
    }
}
