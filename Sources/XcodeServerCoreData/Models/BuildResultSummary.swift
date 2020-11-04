import Foundation
#if canImport(CoreData)
import CoreData

@objc(BuildResultSummary)
public class BuildResultSummary: NSManagedObject {

}

extension BuildResultSummary {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BuildResultSummary> {
        return NSFetchRequest<BuildResultSummary>(entityName: "BuildResultSummary")
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
    @NSManaged public var integration: Integration?

}

#endif
