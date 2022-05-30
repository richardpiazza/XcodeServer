import Foundation
import CoreDataPlus
import XcodeServer
#if canImport(CoreData)
import CoreData

public class ManagedBuildResultSummary: NSManagedObject {

}

extension ManagedBuildResultSummary {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedBuildResultSummary> {
        return NSFetchRequest<ManagedBuildResultSummary>(entityName: "ManagedBuildResultSummary")
    }

    @NSManaged public var analyzerWarningChange: Int32
    @NSManaged public var analyzerWarningCount: Int32
    @NSManaged public var codeCoveragePercentage: Int32
    @NSManaged public var codeCoveragePercentageDelta: Int32
    @NSManaged public var errorChange: Int32
    @NSManaged public var errorCount: Int32
    @NSManaged public var improvedPerfTestCount: Int32
    @NSManaged public var regressedPerfTestCount: Int32
    @NSManaged public var testFailureChange: Int32
    @NSManaged public var testFailureCount: Int32
    @NSManaged public var testsChange: Int32
    @NSManaged public var testsCount: Int32
    @NSManaged public var warningChange: Int32
    @NSManaged public var warningCount: Int32
    @NSManaged public var integration: ManagedIntegration?

}

extension ManagedBuildResultSummary {
    func update(_ summary: Integration.BuildSummary) {
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

extension Integration.BuildSummary {
    init(_ summary: ManagedBuildResultSummary) {
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
