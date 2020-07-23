import Foundation
import XcodeServerCommon
import XcodeServerAPI
#if canImport(CoreData)
import XcodeServerCoreData

extension Trigger {
    public func update(withTrigger trigger: XCSTrigger) {
        guard let moc = self.managedObjectContext else {
            return
        }
        
        self.name = trigger.name
        self.type = TriggerType(rawValue: Int16(trigger.type?.rawValue ?? 0)) ?? .script
        self.phase = TriggerPhase(rawValue: Int16(trigger.phase?.rawValue ?? 0)) ?? .beforeIntegration
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

#endif
