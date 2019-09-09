import Foundation
import CoreData
import XcodeServerCommon

@objc(Issue)
public class Issue: NSManagedObject {
    
    public convenience init?(managedObjectContext: NSManagedObjectContext, identifier: UUID) {
        self.init(managedObjectContext: managedObjectContext)
        self.identifier = identifier
        self.age = 0
        self.lineNumber = 0
        self.statusRawValue = 0
    }
}

// MARK: - CoreData Properties
public extension Issue {
    
    @nonobjc class func fetchRequest() -> NSFetchRequest<Issue> {
        return NSFetchRequest<Issue>(entityName: entityName)
    }
    
    @NSManaged var age: Int32
    @NSManaged var documentFilePath: String?
    @NSManaged var documentLocationData: String?
    @NSManaged var fixItType: String?
    @NSManaged var identifier: UUID?
    @NSManaged var issueType: String?
    @NSManaged var lineNumber: Int32
    @NSManaged var message: String?
    @NSManaged var statusRawValue: Int16
    @NSManaged var target: String?
    @NSManaged var testCase: String?
    @NSManaged var typeRawValue: String?
    
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

public extension Issue {
    var status: IssueStatus {
        get {
            return IssueStatus(rawValue: Int(statusRawValue)) ?? .new
        }
        set {
            statusRawValue = Int16(newValue.rawValue)
        }
    }
    
    var type: IssueType {
        get {
            return IssueType(rawValue: typeRawValue ?? "") ?? .unknown
        } set {
            typeRawValue = newValue.rawValue
        }
    }
}
