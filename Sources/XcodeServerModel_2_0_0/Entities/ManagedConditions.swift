import Foundation
import CoreDataPlus
import XcodeServer
#if canImport(CoreData)
import CoreData

public class ManagedConditions: NSManagedObject {

}

extension ManagedConditions {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedConditions> {
        return NSFetchRequest<ManagedConditions>(entityName: "ManagedConditions")
    }

    @NSManaged public var onAllIssuesResolved: Bool
    @NSManaged public var onAnalyzerWarnings: Bool
    @NSManaged public var onBuildErrors: Bool
    @NSManaged public var onFailingTests: Bool
    @NSManaged public var onInternalErrors: Bool
    @NSManaged public var onSuccess: Bool
    @NSManaged public var onWarnings: Bool
    @NSManaged public var statusRawValue: Int16
    @NSManaged public var trigger: ManagedTrigger?

}

extension ManagedConditions {
    func update(_ conditions: Trigger.Conditions, context: NSManagedObjectContext) {
        onAllIssuesResolved = conditions.onAllIssuesResolved
        onAnalyzerWarnings = conditions.onAnalyzerWarnings
        onBuildErrors = conditions.onBuildErrors
        onFailingTests = conditions.onFailingTests
        onSuccess = conditions.onSuccess
        onWarnings = conditions.onWarnings
        statusRawValue = Int16(conditions.status)
    }
}

extension Trigger.Conditions {
    init(_ conditions: ManagedConditions) {
        self.init()
        status = Int(conditions.statusRawValue)
        onAllIssuesResolved = conditions.onAllIssuesResolved
        onWarnings = conditions.onWarnings
        onBuildErrors = conditions.onBuildErrors
        onAnalyzerWarnings = conditions.onAnalyzerWarnings
        onFailingTests = conditions.onFailingTests
        onSuccess = conditions.onSuccess
    }
}
#endif
