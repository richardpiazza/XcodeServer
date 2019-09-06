import Foundation
import XcodeServerAPI
import XcodeServerCoreData

extension BuildResultSummary {
    public func update(withBuildResultSummary summary: XCSBuildResultSummary) {
        self.errorCount = summary.errorCount as NSNumber?
        self.errorChange = summary.errorChange as NSNumber?
        self.warningCount = summary.warningCount as NSNumber?
        self.warningChange = summary.warningChange as NSNumber?
        self.testsCount = summary.testsCount as NSNumber?
        self.testsChange = summary.testsChange as NSNumber?
        self.testFailureCount = summary.testFailureCount as NSNumber?
        self.testFailureChange = summary.testFailureChange as NSNumber?
        self.analyzerWarningCount = summary.analyzerWarningCount as NSNumber?
        self.analyzerWarningChange = summary.analyzerWarningChange as NSNumber?
        self.regressedPerfTestCount = summary.regressedPerfTestCount as NSNumber?
        self.improvedPerfTestCount = summary.improvedPerfTestCount as NSNumber?
    }
}