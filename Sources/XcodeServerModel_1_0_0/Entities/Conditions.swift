import XcodeServer
import XcodeServerCoreData
import Foundation
#if canImport(CoreData)
import CoreData

//@objc(Conditions)
public class Conditions: NSManagedObject {

}

extension Conditions {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Conditions> {
        return NSFetchRequest<Conditions>(entityName: "Conditions")
    }

    @NSManaged public var onAllIssuesResolved: Bool
    @NSManaged public var onAnalyzerWarnings: Bool
    @NSManaged public var onBuildErrors: Bool
    @NSManaged public var onFailingTests: Bool
    @NSManaged public var onInternalErrors: Bool
    @NSManaged public var onSuccess: Bool
    @NSManaged public var onWarnings: Bool
    @NSManaged public var statusRawValue: Int16
    @NSManaged public var trigger: Trigger?

}

public extension Conditions {
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

public extension XcodeServer.Trigger.Conditions {
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
