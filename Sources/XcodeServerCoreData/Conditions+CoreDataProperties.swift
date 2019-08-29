import Foundation
import CoreData

public extension Conditions {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Conditions> {
        return NSFetchRequest<Conditions>(entityName: "Conditions")
    }
    
    @NSManaged public var onAnalyzerWarnings: NSNumber?
    @NSManaged public var onBuildErrors: NSNumber?
    @NSManaged public var onFailingTests: NSNumber?
    @NSManaged public var onInternalErrors: NSNumber?
    @NSManaged public var onSucess: NSNumber?
    @NSManaged public var onWarnings: NSNumber?
    @NSManaged public var status: NSNumber?
    @NSManaged public var onAllIssuesResolved: NSNumber?
    @NSManaged public var trigger: Trigger?
    
}
