import Foundation
import XcodeServerAPI
import XcodeServerCoreData

extension Trigger {
    public func update(withTrigger trigger: XCSTrigger) {
        guard let moc = self.managedObjectContext else {
            return
        }
        
        self.name = trigger.name
        self.type = trigger.type ?? .script
        self.phase = trigger.phase ?? .beforeIntegration
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
