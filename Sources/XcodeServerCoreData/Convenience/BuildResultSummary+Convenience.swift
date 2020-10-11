import XcodeServer
#if canImport(CoreData)
import CoreData

public extension XcodeServerCoreData.BuildResultSummary {
    func update(_ summary: XcodeServer.Integration.BuildSummary) {
        errorCount = Int32(summary.errorCount)
        errorChange = Int32(summary.errorChange)
        warningCount = Int32(summary.warningCount)
        warningChange = Int32(summary.warningChange)
        testsCount = Int32(summary.testsCount)
        testsChange = Int32(summary.testsChange)
        testFailureCount = Int32(summary.testFailureCount)
        testFailureChange = Int32(summary.testFailureChange)
        analyzerWarningCount = Int32(summary.analyzerWarningCount)
        analyzerWarningChange = Int32(summary.analyzerWarningChange)
        regressedPerfTestCount = Int32(summary.regressedPerfTestCount)
        improvedPerfTestCount = Int32(summary.improvedPerfTestCount)
    }
}
#endif
