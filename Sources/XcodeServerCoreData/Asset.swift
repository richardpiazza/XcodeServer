import Foundation
import CoreData
import XcodeServerAPI

/// ## Asset
/// "Each integration on your server generates a number of files, known as assets. Assets include log files, Xcode archives and installable products like IPA or PKG files."
public class Asset: NSManagedObject {
    
    func update(withAsset asset: XCSIntegrationAsset) {
        self.allowAnonymousAccess = asset.allowAnonymousAccess as NSNumber?
        self.isDirectory = asset.isDirectory as NSNumber?
        self.fileName = asset.fileName
        self.relativePath = asset.relativePath
        self.size = asset.size as NSNumber?
        self.triggerName = asset.triggerName
    }
}
