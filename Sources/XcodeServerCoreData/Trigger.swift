import Foundation
import CoreData
import XcodeServerAPI

public class Trigger: NSManagedObject {
    
    public convenience init?(managedObjectContext: NSManagedObjectContext, configuration: Configuration) {
        self.init(managedObjectContext: managedObjectContext)
        self.configuration = configuration
    }
    
    public func update(withTrigger trigger: XCSTrigger) {
        guard let moc = self.managedObjectContext else {
            return
        }
        
        self.name = trigger.name
        self.type = trigger.type?.rawValue as NSNumber?
        self.phase = trigger.phase?.rawValue as NSNumber?
        self.scriptBody = trigger.scriptBody
        
        if let triggerConditions = trigger.conditions {
            if self.conditions == nil {
                self.conditions = Conditions(managedObjectContext: moc, trigger: self)
            }
            
            if let conditions = self.conditions {
                conditions.update(withConditions: triggerConditions)
            }
        }
        
        if let triggerEmail = trigger.emailConfiguration {
            if self.emailConfiguration == nil {
                self.emailConfiguration = EmailConfiguration(managedObjectContext: moc, trigger: self)
            }
            
            if let emailConfiguration = self.emailConfiguration {
                emailConfiguration.update(withEmailConfiguration: triggerEmail)
            }
        }
    }
}
