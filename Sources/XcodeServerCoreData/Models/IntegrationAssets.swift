import Foundation
#if canImport(CoreData)
import CoreData

@objc(IntegrationAssets)
public class IntegrationAssets: NSManagedObject {
    
    @NSManaged public var archive: Asset?
    @NSManaged public var buildServiceLog: Asset?
    @NSManaged public var integration: Integration?
    @NSManaged public var product: Asset?
    @NSManaged public var sourceControlLog: Asset?
    @NSManaged public var triggerAssets: Set<Asset>?
    @NSManaged public var xcodebuildLog: Asset?
    @NSManaged public var xcodebuildOutput: Asset?
    
}

#endif
