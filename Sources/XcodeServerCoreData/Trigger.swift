import Foundation
import CoreData
import XcodeServerCommon

@objc(Trigger)
public class Trigger: NSManagedObject {
    
    public convenience init?(managedObjectContext: NSManagedObjectContext, configuration: Configuration) {
        self.init(managedObjectContext: managedObjectContext)
        self.configuration = configuration
        phaseRawValue = 0
        typeRawValue = 0
    }
}

// MARK: - CoreData Properties
public extension Trigger {
    
    @NSManaged var name: String?
    @NSManaged var phaseRawValue: Int16
    @NSManaged var scriptBody: String?
    @NSManaged var typeRawValue: Int16
    @NSManaged var conditions: Conditions?
    @NSManaged var configuration: Configuration?
    @NSManaged var emailConfiguration: EmailConfiguration?
    
}

public extension Trigger {
    var phase: TriggerPhase {
        get {
            return TriggerPhase(rawValue: Int(phaseRawValue)) ?? .beforeIntegration
        }
        set {
            phaseRawValue = Int16(newValue.rawValue)
        }
    }
    
    var type: TriggerType {
        get {
            return TriggerType(rawValue: Int(typeRawValue)) ?? .script
        }
        set {
            typeRawValue = Int16(newValue.rawValue)
        }
    }
}
