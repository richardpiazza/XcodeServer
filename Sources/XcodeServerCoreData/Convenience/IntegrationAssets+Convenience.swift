import XcodeServer
#if canImport(CoreData)
import CoreData

public extension IntegrationAssets {
    func update(_ catalog: XcodeServer.Integration.AssetCatalog, context: NSManagedObjectContext) {
        switch (archive, catalog.archive) {
        case (.none, .some(let asset)):
            archive = Asset(context: context)
            fallthrough
        case (.some, .some(let asset)):
            archive?.update(asset)
        case (.some, .none):
            archive = nil
        case (.none, .none):
            break
        }
        
        switch (buildServiceLog) {
        case .none:
            buildServiceLog = Asset(context: context)
            fallthrough
        case .some:
            buildServiceLog?.update(catalog.buildServiceLog)
        }
        
        switch (product, catalog.product) {
        case (.none, .some(let asset)):
            product = Asset(context: context)
            fallthrough
        case (.some, .some(let asset)):
            product?.update(asset)
        case (.some, .none):
            product = nil
        case (.none, .none):
            break
        }
        
        switch (sourceControlLog) {
        case .none:
            sourceControlLog = Asset(context: context)
            fallthrough
        case .some:
            sourceControlLog?.update(catalog.sourceControlLog)
        }
        
        switch (xcodebuildLog, catalog.xcodebuildLog) {
        case (.none, .some(let asset)):
            xcodebuildLog = Asset(context: context)
            fallthrough
        case (.some, .some(let asset)):
            xcodebuildLog?.update(asset)
        case (.some, .none):
            xcodebuildLog = nil
        case (.none, .none):
            break
        }
        
        switch (xcodebuildOutput, catalog.xcodebuildOutput) {
        case (.none, .some(let asset)):
            xcodebuildOutput = Asset(context: context)
            fallthrough
        case (.some, .some(let asset)):
            xcodebuildOutput?.update(asset)
        case (.some, .none):
            xcodebuildOutput = nil
        case (.none, .none):
            break
        }
        
        triggerAssets?.forEach({
            $0.inverseTriggerAssets = nil
            context.delete($0)
        })
        
        catalog.triggerAssets.forEach({
            let asset = Asset(context: context)
            asset.update($0)
            asset.inverseTriggerAssets = self
        })
    }
}

/*
 extension XcodeServerCoreData.IntegrationAssets {
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
             
             let asset = Asset(context: moc)
             asset.inverseArchive = self
             asset.update(withAsset: archiveAsset)
             self.archive = asset
         }
         
         // Build Service Log
         if let logAsset = assets.buildServiceLog {
             if let buildServiceLog = self.buildServiceLog {
                 moc.delete(buildServiceLog)
                 self.buildServiceLog = nil
             }
             
             let asset = Asset(context: moc)
             asset.inverseBuildServiceLog = self
             asset.update(withAsset: logAsset)
             self.buildServiceLog = asset
         }
         
         // Product
         if let productAsset = assets.product {
             if let product = self.product {
                 moc.delete(product)
                 self.product = nil
             }
             
             let asset = Asset(context: moc)
             asset.inverseProduct = self
             asset.update(withAsset: productAsset)
             self.product = asset
         }
         
         // Source Control Log
         if let logAsset = assets.sourceControlLog {
             if let sourceControlLog = self.sourceControlLog {
                 moc.delete(sourceControlLog)
                 self.sourceControlLog = nil
             }
             
             let asset = Asset(context: moc)
             asset.inverseSourceControlLog = self
             asset.update(withAsset: logAsset)
             self.sourceControlLog = asset
         }
         
         // Xcode Build Log
         if let logAsset = assets.xcodebuildLog {
             if let xcodebuildLog = self.xcodebuildLog {
                 moc.delete(xcodebuildLog)
                 self.xcodebuildLog = nil
             }
             
             let asset = Asset(context: moc)
             asset.inverseXcodebuildLog = self
             asset.update(withAsset: logAsset)
             self.xcodebuildLog = asset
         }
         
         // Xcode Build Output
         if let outputAsset = assets.xcodebuildOutput {
             if let xcodebuildOutput = self.xcodebuildOutput {
                 moc.delete(xcodebuildOutput)
                 self.xcodebuildOutput = nil
             }
             
             let asset = Asset(context: moc)
             asset.inverseXcodebuildOutput = self
             asset.update(withAsset: outputAsset)
             self.xcodebuildOutput = asset
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
                 let asset = Asset(context: moc)
                 asset.inverseTriggerAssets = self
                 asset.update(withAsset: triggerAsset)
             }
         }
     }
 }
 */

#endif
