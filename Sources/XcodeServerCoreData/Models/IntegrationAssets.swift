import Foundation
#if canImport(CoreData)
import CoreData

@objc(IntegrationAssets)
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
#endif
