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
        
        triggerAssets?.removeAll()
        catalog.triggerAssets.forEach({
            let asset = Asset(context: context)
            asset.update($0)
            asset.inverseTriggerAssets = self
        })
    }
}
#endif
