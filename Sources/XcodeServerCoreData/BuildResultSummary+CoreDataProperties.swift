import Foundation
import CoreData

public extension BuildResultSummary {

    @NSManaged var analyzerWarningChange: NSNumber?
    @NSManaged var analyzerWarningCount: NSNumber?
    @NSManaged var codeCoveragePercentage: NSNumber?
    @NSManaged var codeCoveragePercentageDelta: NSNumber?
    @NSManaged var errorChange: NSNumber?
    @NSManaged var errorCount: NSNumber?
    @NSManaged var improvedPerfTestCount: NSNumber?
    @NSManaged var regressedPerfTestCount: NSNumber?
    @NSManaged var testFailureChange: NSNumber?
    @NSManaged var testFailureCount: NSNumber?
    @NSManaged var testsChange: NSNumber?
    @NSManaged var testsCount: NSNumber?
    @NSManaged var warningChange: NSNumber?
    @NSManaged var warningCount: NSNumber?
    @NSManaged var integration: Integration?

}
