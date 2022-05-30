import Foundation
import CoreDataPlus
import XcodeServer
#if canImport(CoreData)
import CoreData

public class ManagedIntegrationAssets: NSManagedObject {

}

extension ManagedIntegrationAssets {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedIntegrationAssets> {
        return NSFetchRequest<ManagedIntegrationAssets>(entityName: "ManagedIntegrationAssets")
    }

    @NSManaged public var archive: ManagedAsset?
    @NSManaged public var buildServiceLog: ManagedAsset?
    @NSManaged public var integration: ManagedIntegration?
    @NSManaged public var product: ManagedAsset?
    @NSManaged public var sourceControlLog: ManagedAsset?
    @NSManaged public var triggerAssets: NSSet?
    @NSManaged public var xcodebuildLog: ManagedAsset?
    @NSManaged public var xcodebuildOutput: ManagedAsset?

}

// MARK: Generated accessors for triggerAssets
extension ManagedIntegrationAssets {

    @objc(addTriggerAssetsObject:)
    @NSManaged public func addToTriggerAssets(_ value: ManagedAsset)

    @objc(removeTriggerAssetsObject:)
    @NSManaged public func removeFromTriggerAssets(_ value: ManagedAsset)

    @objc(addTriggerAssets:)
    @NSManaged public func addToTriggerAssets(_ values: NSSet)

    @objc(removeTriggerAssets:)
    @NSManaged public func removeFromTriggerAssets(_ values: NSSet)

}

extension ManagedIntegrationAssets {
    func update(_ catalog: Integration.AssetCatalog, context: NSManagedObjectContext) {
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
        
        (triggerAssets as? Set<ManagedAsset>)?.forEach({ context.delete($0) })
        
        catalog.triggerAssets.forEach({
            let asset: ManagedAsset = context.make()
            asset.update($0)
            addToTriggerAssets(asset)
        })
    }
}

extension Integration.AssetCatalog {
    init(_ assets: ManagedIntegrationAssets) {
        self.init()
        if let asset = assets.triggerAssets as? Set<ManagedAsset> {
            triggerAssets = asset.map { Integration.Asset($0) }
        }
        if let asset = assets.sourceControlLog {
            sourceControlLog = Integration.Asset(asset)
        }
        if let asset = assets.buildServiceLog {
            buildServiceLog = Integration.Asset(asset)
        }
        if let asset = assets.xcodebuildLog {
            xcodebuildLog = Integration.Asset(asset)
        }
        if let asset = assets.xcodebuildOutput {
            xcodebuildOutput = Integration.Asset(asset)
        }
        if let asset = assets.archive {
            archive = Integration.Asset(asset)
        }
        if let asset = assets.product {
            product = Integration.Asset(asset)
        }
    }
}
#endif
