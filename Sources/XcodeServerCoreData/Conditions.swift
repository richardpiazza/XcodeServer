import Foundation
#if canImport(CoreData)
import CoreData

@objc(Conditions)
public class Conditions: NSManagedObject {
    
    public convenience init?(managedObjectContext: NSManagedObjectContext, trigger: Trigger) {
        self.init(managedObjectContext: managedObjectContext)
        self.trigger = trigger
        self.onAllIssuesResolved = false
        self.onAnalyzerWarnings = false
        self.onBuildErrors = false
        self.onFailingTests = false
        self.onInternalErrors = false
        self.onSuccess = false
        self.onWarnings = false
        self.statusRawValue = 0
    }
}

// MARK: - CoreData Properties
public extension Conditions {
    
    @nonobjc class func fetchRequest() -> NSFetchRequest<Conditions> {
        return NSFetchRequest<Conditions>(entityName: entityName)
    }
    
    @NSManaged var onAllIssuesResolved: Bool
    @NSManaged var onAnalyzerWarnings: Bool
    @NSManaged var onBuildErrors: Bool
    @NSManaged var onFailingTests: Bool
    @NSManaged var onInternalErrors: Bool
    @NSManaged var onSuccess: Bool
    @NSManaged var onWarnings: Bool
    @NSManaged var statusRawValue: Int16
    @NSManaged var trigger: Trigger?
    
}

#endif
