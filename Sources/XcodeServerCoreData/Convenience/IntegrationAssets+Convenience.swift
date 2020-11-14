import XcodeServer
#if canImport(CoreData)
import CoreData

public extension IntegrationAssets {
    func update(_ catalog: XcodeServer.Integration.AssetCatalog, context: NSManagedObjectContext) {
        switch (archive, catalog.archive) {
        case (.none, .some(let asset)):
            archive = context.make()
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
            buildServiceLog = context.make()
            fallthrough
        case .some:
            buildServiceLog?.update(catalog.buildServiceLog)
        }
        
        switch (product, catalog.product) {
        case (.none, .some(let asset)):
            product = context.make()
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
            sourceControlLog = context.make()
            fallthrough
        case .some:
            sourceControlLog?.update(catalog.sourceControlLog)
        }
        
        switch (xcodebuildLog, catalog.xcodebuildLog) {
        case (.none, .some(let asset)):
            xcodebuildLog = context.make()
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
            xcodebuildOutput = context.make()
            fallthrough
        case (.some, .some(let asset)):
            xcodebuildOutput?.update(asset)
        case (.some, .none):
            xcodebuildOutput = nil
        case (.none, .none):
            break
        }
        
        (triggerAssets as? Set<Asset>)?.forEach({ context.delete($0) })
        
        catalog.triggerAssets.forEach({
            let asset: Asset = context.make()
            asset.update($0)
            addToTriggerAssets(asset)
        })
    }
}
#endif
