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

/*
 extension XcodeServerCoreData.Conditions {
     public func update(withConditions conditions: XCSConditions) {
         self.onAllIssuesResolved = conditions.onAllIssuesResolved ?? false
         self.onWarnings = conditions.onWarnings ?? false
         self.onBuildErrors = conditions.onBuildErrors ?? false
         self.onAnalyzerWarnings = conditions.onAnalyzerWarnings ?? false
         self.onFailingTests = conditions.onFailingTests ?? false
         self.onSuccess = conditions.onSuccess ?? false
         self.statusRawValue = Int16(conditions.status ?? 0)
     }
 }
 */

#endif
