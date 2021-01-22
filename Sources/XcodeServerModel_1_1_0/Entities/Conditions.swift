import XcodeServer
import CoreDataPlus
import Foundation
#if canImport(CoreData)
import CoreData

//@objc(Conditions)
class Conditions: NSManagedObject {

}

extension Conditions {

    @nonobjc class func fetchRequest() -> NSFetchRequest<Conditions> {
        return NSFetchRequest<Conditions>(entityName: "Conditions")
    }

    @NSManaged var onAllIssuesResolved: Bool
    @NSManaged var onAnalyzerWarnings: Bool
    @NSManaged var onBuildErrors: Bool
    @NSManaged var onFailingTests: Bool
    @NSManaged var onInternalErrors: Bool
    @NSManaged var onSuccess: Bool
    @NSManaged var onWarnings: Bool
    @NSManaged var statusRawValue: Int16
    @NSManaged var trigger: Trigger?

}

extension Conditions {
    func update(_ conditions: XcodeServer.Trigger.Conditions, context: NSManagedObjectContext) {
        onAllIssuesResolved = conditions.onAllIssuesResolved
        onAnalyzerWarnings = conditions.onAnalyzerWarnings
        onBuildErrors = conditions.onBuildErrors
        onFailingTests = conditions.onFailingTests
        onSuccess = conditions.onSuccess
        onWarnings = conditions.onWarnings
        statusRawValue = Int16(conditions.status)
    }
}

extension XcodeServer.Trigger.Conditions {
    init(_ conditions: Conditions) {
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
