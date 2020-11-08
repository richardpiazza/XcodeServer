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
            conditions = context.make()
        }
        if emailConfiguration == nil {
            emailConfiguration = context.make()
        }
        
        conditions?.update(trigger.conditions, context: context)
        emailConfiguration?.update(trigger.email)
        name = trigger.name
        phase = trigger.phase
        scriptBody = trigger.scriptBody
        type = trigger.type
    }
}
#endif
