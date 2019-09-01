import Foundation
import XcodeServerAPI
import XcodeServerCoreData

extension Asset {
    func update(withAsset asset: XCSIntegrationAsset) {
        self.allowAnonymousAccess = asset.allowAnonymousAccess as NSNumber?
        self.isDirectory = asset.isDirectory as NSNumber?
        self.fileName = asset.fileName
        self.relativePath = asset.relativePath
        self.size = asset.size as NSNumber?
        self.triggerName = asset.triggerName
    }
}
