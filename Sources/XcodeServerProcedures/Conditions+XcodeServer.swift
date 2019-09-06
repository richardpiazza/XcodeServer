import Foundation
import XcodeServerAPI
import XcodeServerCoreData

extension Conditions {
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
