import Foundation
#if canImport(CoreData)
import CoreData

@objc(Issue)
public class Issue: NSManagedObject {

}

extension Issue {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Issue> {
        return NSFetchRequest<Issue>(entityName: "Issue")
    }

    @NSManaged public var age: Int32
    @NSManaged public var documentFilePath: String?
    @NSManaged public var documentLocationData: String?
    @NSManaged public var fixItType: String?
    @NSManaged public var identifier: String?
    @NSManaged public var issueType: String?
    @NSManaged public var lineNumber: Int32
    @NSManaged public var message: String?
    @NSManaged public var statusRawValue: Int16
    @NSManaged public var target: String?
    @NSManaged public var testCase: String?
    @NSManaged public var typeRawValue: String?
    @NSManaged public var inverseBuildServiceErrors: IntegrationIssues?
    @NSManaged public var inverseBuildServiceWarnings: IntegrationIssues?
    @NSManaged public var inverseFreshAnalyzerWarnings: IntegrationIssues?
    @NSManaged public var inverseFreshErrors: IntegrationIssues?
    @NSManaged public var inverseFreshTestFailures: IntegrationIssues?
    @NSManaged public var inverseFreshWarnings: IntegrationIssues?
    @NSManaged public var inverseResolvedAnalyzerWarnings: IntegrationIssues?
    @NSManaged public var inverseResolvedErrors: IntegrationIssues?
    @NSManaged public var inverseResolvedTestFailures: IntegrationIssues?
    @NSManaged public var inverseResolvedWarnings: IntegrationIssues?
    @NSManaged public var inverseUnresolvedAnalyzerWarnings: IntegrationIssues?
    @NSManaged public var inverseUnresolvedErrors: IntegrationIssues?
    @NSManaged public var inverseUnresolvedTestFailures: IntegrationIssues?
    @NSManaged public var inverseUnresolvedWarnings: IntegrationIssues?

}
#endif
