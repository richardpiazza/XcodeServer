import Foundation
import CoreData
import XcodeServerAPI

public class IntegrationAssets: NSManagedObject {
    
    public convenience init?(managedObjectContext: NSManagedObjectContext, integration: Integration) {
        self.init(managedObjectContext: managedObjectContext)
        self.integration = integration
    }
    
    public func update(withIntegrationAssets assets: XCSAssets) {
        guard let moc = self.managedObjectContext else {
            return
        }
        
        // Archive
        if let archiveAsset = assets.archive {
            if let archive = self.archive {
                moc.delete(archive)
                self.archive = nil
            }
        
            if let asset = Asset(managedObjectContext: moc) {
                asset.inverseArchive = self
                asset.update(withAsset: archiveAsset)
                self.archive = asset
            }
        }
        
        // Build Service Log
        if let logAsset = assets.buildServiceLog {
            if let buildServiceLog = self.buildServiceLog {
                moc.delete(buildServiceLog)
                self.buildServiceLog = nil
            }
            
            if let asset = Asset(managedObjectContext: moc) {
                asset.inverseBuildServiceLog = self
                asset.update(withAsset: logAsset)
                self.buildServiceLog = asset
            }
        }
        
        // Product
        if let productAsset = assets.product {
            if let product = self.product {
                moc.delete(product)
                self.product = nil
            }
            
            if let asset = Asset(managedObjectContext: moc) {
                asset.inverseProduct = self
                asset.update(withAsset: productAsset)
                self.product = asset
            }
        }
        
        // Source Control Log
        if let logAsset = assets.sourceControlLog {
            if let sourceControlLog = self.sourceControlLog {
                moc.delete(sourceControlLog)
                self.sourceControlLog = nil
            }
            
            if let asset = Asset(managedObjectContext: moc) {
                asset.inverseSourceControlLog = self
                asset.update(withAsset: logAsset)
                self.sourceControlLog = asset
            }
        }
        
        // Xcode Build Log
        if let logAsset = assets.xcodebuildLog {
            if let xcodebuildLog = self.xcodebuildLog {
                moc.delete(xcodebuildLog)
                self.xcodebuildLog = nil
            }
            
            if let asset = Asset(managedObjectContext: moc) {
                asset.inverseXcodebuildLog = self
                asset.update(withAsset: logAsset)
                self.xcodebuildLog = asset
            }
        }
        
        // Xcode Build Output
        if let outputAsset = assets.xcodebuildOutput {
            if let xcodebuildOutput = self.xcodebuildOutput {
                moc.delete(xcodebuildOutput)
                self.xcodebuildOutput = nil
            }
            
            if let asset = Asset(managedObjectContext: moc) {
                asset.inverseXcodebuildOutput = self
                asset.update(withAsset: outputAsset)
                self.xcodebuildOutput = asset
            }
        }
        
        // Trigger Assets
        if let triggerAssets = assets.triggerAssets {
            if let set = self.triggerAssets {
                for asset in set {
                    asset.inverseTriggerAssets = nil
                    moc.delete(asset)
                }
            }
            
            for triggerAsset in triggerAssets {
                if let asset = Asset(managedObjectContext: moc) {
                    asset.inverseTriggerAssets = self
                    asset.update(withAsset: triggerAsset)
                }
            }
        }
    }
}
