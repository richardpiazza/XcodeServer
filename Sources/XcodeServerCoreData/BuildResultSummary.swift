import Foundation
import CoreData

@objc(BuildResultSummary)
public class BuildResultSummary: NSManagedObject {
    
    public convenience init?(managedObjectContext: NSManagedObjectContext, integration: Integration) {
        self.init(managedObjectContext: managedObjectContext)
        self.integration = integration
        self.analyzerWarningChange = 0
        self.analyzerWarningCount = 0
        self.codeCoveragePercentage = 0
        self.codeCoveragePercentageDelta = 0
        self.errorChange = 0
        self.errorCount = 0
        self.improvedPerfTestCount = 0
        self.regressedPerfTestCount = 0
        self.testFailureChange = 0
        self.testFailureCount = 0
        self.testsChange = 0
        self.testsCount = 0
        self.warningChange = 0
        self.warningCount = 0
    }
}

// MARK: - CoreData Properties
public extension BuildResultSummary {
    
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
