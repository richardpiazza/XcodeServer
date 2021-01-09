import XcodeServer
import XcodeServerCoreData
import Foundation
#if canImport(CoreData)
import CoreData

//@objc(IntegrationAssets)
public class IntegrationAssets: NSManagedObject {

}

extension IntegrationAssets {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<IntegrationAssets> {
        return NSFetchRequest<IntegrationAssets>(entityName: "IntegrationAssets")
    }

    @NSManaged public var archive: Asset?
    @NSManaged public var buildServiceLog: Asset?
    @NSManaged public var integration: Integration?
    @NSManaged public var product: Asset?
    @NSManaged public var sourceControlLog: Asset?
    @NSManaged public var triggerAssets: NSSet?
    @NSManaged public var xcodebuildLog: Asset?
    @NSManaged public var xcodebuildOutput: Asset?

}

// MARK: Generated accessors for triggerAssets
extension IntegrationAssets {

    @objc(addTriggerAssetsObject:)
    @NSManaged public func addToTriggerAssets(_ value: Asset)

    @objc(removeTriggerAssetsObject:)
    @NSManaged public func removeFromTriggerAssets(_ value: Asset)

    @objc(addTriggerAssets:)
    @NSManaged public func addToTriggerAssets(_ values: NSSet)

    @objc(removeTriggerAssets:)
    @NSManaged public func removeFromTriggerAssets(_ values: NSSet)

}

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

public extension XcodeServer.Integration.AssetCatalog {
    init(_ assets: IntegrationAssets) {
        self.init()
        if let asset = assets.triggerAssets as? Set<Asset> {
            triggerAssets = asset.map { XcodeServer.Integration.Asset($0) }
        }
        if let asset = assets.sourceControlLog {
            sourceControlLog = XcodeServer.Integration.Asset(asset)
        }
        if let asset = assets.buildServiceLog {
            buildServiceLog = XcodeServer.Integration.Asset(asset)
        }
        if let asset = assets.xcodebuildLog {
            xcodebuildLog = XcodeServer.Integration.Asset(asset)
        }
        if let asset = assets.xcodebuildOutput {
            xcodebuildOutput = XcodeServer.Integration.Asset(asset)
        }
        if let asset = assets.archive {
            archive = XcodeServer.Integration.Asset(asset)
        }
        if let asset = assets.product {
            product = XcodeServer.Integration.Asset(asset)
        }
    }
}
#endif
