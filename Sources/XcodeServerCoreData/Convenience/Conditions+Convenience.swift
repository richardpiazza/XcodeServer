import XcodeServer
#if canImport(CoreData)
import CoreData

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
#endif
