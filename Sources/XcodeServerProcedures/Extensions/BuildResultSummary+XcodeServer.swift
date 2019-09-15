import Foundation
import XcodeServerAPI
#if canImport(CoreData)
import XcodeServerCoreData

extension BuildResultSummary {
    public func update(withBuildResultSummary summary: XCSBuildResultSummary) {
        self.errorCount = Int32(summary.errorCount)
        self.errorChange = Int32(summary.errorChange)
        self.warningCount = Int32(summary.warningCount)
        self.warningChange = Int32(summary.warningChange)
        self.testsCount = Int32(summary.testsCount)
        self.testsChange = Int32(summary.testsChange)
        self.testFailureCount = Int32(summary.testFailureCount)
        self.testFailureChange = Int32(summary.testFailureChange)
        self.analyzerWarningCount = Int32(summary.analyzerWarningCount)
        self.analyzerWarningChange = Int32(summary.analyzerWarningChange)
        self.regressedPerfTestCount = Int32(summary.regressedPerfTestCount)
        self.improvedPerfTestCount = Int32(summary.improvedPerfTestCount)
    }
}

#endif
