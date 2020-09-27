import XcodeServer
#if canImport(CoreData)
import CoreData

public extension Trigger {
    var phase: XcodeServer.Trigger.Phase {
        get {
            return XcodeServer.Trigger.Phase(rawValue: Int(phaseRawValue)) ?? .beforeIntegration
        }
        set {
            phaseRawValue = Int16(newValue.rawValue)
        }
    }
    
    var type: XcodeServer.Trigger.Category {
        get {
            return XcodeServer.Trigger.Category(rawValue: Int(typeRawValue)) ?? .script
        }
        set {
            typeRawValue = Int16(newValue.rawValue)
        }
    }
}

public extension Trigger {
    func update(_ trigger: XcodeServer.Trigger, context: NSManagedObjectContext) {
        if conditions == nil {
            conditions = Conditions(context: context)
        }
        if emailConfiguration == nil {
            emailConfiguration = EmailConfiguration(context: context)
        }
        
        conditions?.update(trigger.conditions, context: context)
        emailConfiguration?.update(trigger.email)
        name = trigger.name
        phase = trigger.phase
        scriptBody = trigger.scriptBody
        type = trigger.type
    }
}

/*
 extension XcodeServerCoreData.Trigger {
     public func update(withTrigger trigger: XCSTrigger) {
         guard let moc = self.managedObjectContext else {
             return
         }
         
         self.name = trigger.name
         self.type = XcodeServer.Trigger.Category(rawValue: Int(trigger.type?.rawValue ?? 0)) ?? .script
         self.phase = XcodeServer.Trigger.Phase(rawValue: Int(trigger.phase?.rawValue ?? 0)) ?? .beforeIntegration
         self.scriptBody = trigger.scriptBody
         
         if let triggerConditions = trigger.conditions {
             if conditions == nil {
                 conditions = Conditions(context: moc)
                 conditions?.trigger = self
             }
             
             conditions?.update(withConditions: triggerConditions)
         }
         
         if let triggerEmail = trigger.emailConfiguration {
             if emailConfiguration == nil {
                 emailConfiguration = EmailConfiguration(context: moc)
                 emailConfiguration?.trigger = self
             }
             
             emailConfiguration?.update(withEmailConfiguration: triggerEmail)
         }
     }
 }
 */

#endif
