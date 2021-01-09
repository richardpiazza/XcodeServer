import XcodeServer
import XcodeServerCoreData
import Foundation
#if canImport(CoreData)
import CoreData

//@objc(Trigger)
public class Trigger: NSManagedObject {

}

extension Trigger {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Trigger> {
        return NSFetchRequest<Trigger>(entityName: "Trigger")
    }

    @NSManaged public var name: String?
    @NSManaged public var phaseRawValue: Int16
    @NSManaged public var scriptBody: String?
    @NSManaged public var typeRawValue: Int16
    @NSManaged public var conditions: Conditions?
    @NSManaged public var configuration: Configuration?
    @NSManaged public var emailConfiguration: EmailConfiguration?

}

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

public extension XcodeServer.Trigger {
    init(_ trigger: Trigger) {
        self.init()
        name = trigger.name ?? ""
        type = trigger.type
        phase = trigger.phase
        scriptBody = trigger.scriptBody ?? ""
        if let config = trigger.emailConfiguration {
            email = XcodeServer.Trigger.Email(config)
        }
        if let conditions = trigger.conditions {
            self.conditions = XcodeServer.Trigger.Conditions(conditions)
        }
    }
}
#endif
