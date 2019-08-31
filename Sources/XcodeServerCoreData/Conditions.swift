import Foundation
import CoreData

@objc(Conditions)
public class Conditions: NSManagedObject {
    
    public convenience init?(managedObjectContext: NSManagedObjectContext, trigger: Trigger) {
        self.init(managedObjectContext: managedObjectContext)
        self.trigger = trigger
    }
}

// MARK: - CoreData Properties
public extension Conditions {
    
    @nonobjc class func fetchRequest() -> NSFetchRequest<Conditions> {
        return NSFetchRequest<Conditions>(entityName: entityName)
    }
    
    @NSManaged var onAnalyzerWarnings: NSNumber?
    @NSManaged var onBuildErrors: NSNumber?
    @NSManaged var onFailingTests: NSNumber?
    @NSManaged var onInternalErrors: NSNumber?
    @NSManaged var onSucess: NSNumber?
    @NSManaged var onWarnings: NSNumber?
    @NSManaged var status: NSNumber?
    @NSManaged var onAllIssuesResolved: NSNumber?
    @NSManaged var trigger: Trigger?
    
}
