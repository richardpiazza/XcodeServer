import XcodeServer
import CoreDataPlus
import Foundation
#if canImport(CoreData)
import CoreData

//@objc(BuildResultSummary)
class BuildResultSummary: NSManagedObject {

}

extension BuildResultSummary {

    @nonobjc class func fetchRequest() -> NSFetchRequest<BuildResultSummary> {
        return NSFetchRequest<BuildResultSummary>(entityName: "BuildResultSummary")
    }

    @NSManaged var analyzerWarningChange: Int32
    @NSManaged var analyzerWarningCount: Int32
    @NSManaged var codeCoveragePercentage: Int32
    @NSManaged var codeCoveragePercentageDelta: Int32
    @NSManaged var errorChange: Int32
    @NSManaged var errorCount: Int32
    @NSManaged var improvedPerfTestCount: Int32
    @NSManaged var regressedPerfTestCount: Int32
    @NSManaged var testFailureChange: Int32
    @NSManaged var testFailureCount: Int32
    @NSManaged var testsChange: Int32
    @NSManaged var testsCount: Int32
    @NSManaged var warningChange: Int32
    @NSManaged var warningCount: Int32
    @NSManaged var integration: Integration?

}

extension BuildResultSummary {
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

extension XcodeServer.Integration.BuildSummary {
    init(_ summary: BuildResultSummary) {
        self.init()
        errorCount = Int(summary.errorCount)
        errorChange = Int(summary.errorChange)
        warningCount = Int(summary.warningCount)
        warningChange = Int(summary.warningChange)
        testsCount = Int(summary.testsCount)
        testsChange = Int(summary.testsChange)
        testFailureCount = Int(summary.testFailureCount)
        testFailureChange = Int(summary.testFailureChange)
        analyzerWarningCount = Int(summary.analyzerWarningCount)
        analyzerWarningChange = Int(summary.analyzerWarningChange)
        regressedPerfTestCount = Int(summary.regressedPerfTestCount)
        improvedPerfTestCount = Int(summary.improvedPerfTestCount)
        codeCoveragePercentage = Int(summary.codeCoveragePercentage)
        codeCoveragePercentageDelta = Int(summary.codeCoveragePercentageDelta)
    }
}
#endif
