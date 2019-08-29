import Foundation
import CoreData
import XcodeServerAPI

public class Conditions: NSManagedObject {
    
    public convenience init?(managedObjectContext: NSManagedObjectContext, trigger: Trigger) {
        self.init(managedObjectContext: managedObjectContext)
        self.trigger = trigger
    }
    
    public func update(withConditions conditions: XCSConditions) {
        self.status = conditions.status as NSNumber?
        self.onWarnings = conditions.onWarnings as NSNumber?
        self.onBuildErrors = conditions.onBuildErrors as NSNumber?
        self.onAnalyzerWarnings = conditions.onAnalyzerWarnings as NSNumber?
        self.onFailingTests = conditions.onFailingTests as NSNumber?
        self.onSucess = conditions.onSuccess as NSNumber?
        self.onAllIssuesResolved = conditions.onAllIssuesResolved as NSNumber?
    }
}
