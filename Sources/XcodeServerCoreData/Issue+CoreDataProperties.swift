import Foundation
import CoreData

public extension Issue {
    
    @nonobjc class func fetchRequest() -> NSFetchRequest<Issue> {
        return NSFetchRequest<Issue>(entityName: "Issue")
    }
    
    @NSManaged var age: NSNumber?
    @NSManaged var identifier: String?
    @NSManaged var issueType: String?
    @NSManaged var testCase: String?
    @NSManaged var documentFilePath: String?
    @NSManaged var documentLocationData: String?
    @NSManaged var lineNumber: NSNumber?
    @NSManaged var message: String?
    @NSManaged var revision: String?
    @NSManaged var status: NSNumber?
    @NSManaged var target: String?
    @NSManaged var type: String?
    @NSManaged var fixItType: String?
    @NSManaged var inverseBuildServiceErrors: IntegrationIssues?
    @NSManaged var inverseBuildServiceWarnings: IntegrationIssues?
    @NSManaged var inverseFreshAnalyserWarnings: IntegrationIssues?
    @NSManaged var inverseFreshErrors: IntegrationIssues?
    @NSManaged var inverseFreshTestFailures: IntegrationIssues?
    @NSManaged var inverseFreshWarnings: IntegrationIssues?
    @NSManaged var inverseResolvedAnalyzerWarnings: IntegrationIssues?
    @NSManaged var inverseResolvedErrors: IntegrationIssues?
    @NSManaged var inverseResolvedTestFailures: IntegrationIssues?
    @NSManaged var inverseResolvedWarnings: IntegrationIssues?
    @NSManaged var inverseUnresolvedAnalyzerWarnings: IntegrationIssues?
    @NSManaged var inverseUnresolvedErrors: IntegrationIssues?
    @NSManaged var inverseUnresolvedTestFailures: IntegrationIssues?
    @NSManaged var inverseUnresolvedWarnings: IntegrationIssues?
    
}
