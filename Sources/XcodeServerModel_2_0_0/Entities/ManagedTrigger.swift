import Foundation
import CoreDataPlus
import XcodeServer
#if canImport(CoreData)
import CoreData

public class ManagedTrigger: NSManagedObject {

}

extension ManagedTrigger {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedTrigger> {
        return NSFetchRequest<ManagedTrigger>(entityName: "ManagedTrigger")
    }

    @NSManaged public var name: String?
    @NSManaged public var phaseRawValue: Int16
    @NSManaged public var scriptBody: String?
    @NSManaged public var typeRawValue: Int16
    @NSManaged public var conditions: ManagedConditions?
    @NSManaged public var configuration: ManagedConfiguration?
    @NSManaged public var emailConfiguration: ManagedEmailConfiguration?

}

extension ManagedTrigger {
    var phase: Trigger.Phase {
        get { Trigger.Phase(rawValue: Int(phaseRawValue)) ?? .beforeIntegration }
        set { phaseRawValue = Int16(newValue.rawValue) }
    }
    
    var type: Trigger.Category {
        get { Trigger.Category(rawValue: Int(typeRawValue)) ?? .script }
        set { typeRawValue = Int16(newValue.rawValue) }
    }
}

extension ManagedTrigger {
    func update(_ trigger: Trigger, context: NSManagedObjectContext) {
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

extension Trigger {
    init(_ trigger: ManagedTrigger) {
        self.init()
        name = trigger.name ?? ""
        type = trigger.type
        phase = trigger.phase
        scriptBody = trigger.scriptBody ?? ""
        if let config = trigger.emailConfiguration {
            email = Trigger.Email(config)
        }
        if let conditions = trigger.conditions {
            self.conditions = Trigger.Conditions(conditions)
        }
    }
}
#endif
