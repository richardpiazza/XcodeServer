import Foundation
import CoreData

public extension Conditions {
    
    @nonobjc class func fetchRequest() -> NSFetchRequest<Conditions> {
        return NSFetchRequest<Conditions>(entityName: "Conditions")
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
