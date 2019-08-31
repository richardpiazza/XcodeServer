import Foundation
import CoreData

@objc(IntegrationAssets)
public class IntegrationAssets: NSManagedObject {
    
    public convenience init?(managedObjectContext: NSManagedObjectContext, integration: Integration) {
        self.init(managedObjectContext: managedObjectContext)
        self.integration = integration
    }
}

// MARK: - CoreData Properties
public extension IntegrationAssets {
    
    @NSManaged var archive: Asset?
    @NSManaged var buildServiceLog: Asset?
    @NSManaged var integration: Integration?
    @NSManaged var product: Asset?
    @NSManaged var sourceControlLog: Asset?
    @NSManaged var triggerAssets: Set<Asset>?
    @NSManaged var xcodebuildLog: Asset?
    @NSManaged var xcodebuildOutput: Asset?
    
}
