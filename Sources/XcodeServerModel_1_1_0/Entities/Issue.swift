import XcodeServer
import XcodeServerCoreData
import Foundation
#if canImport(CoreData)
import CoreData

//@objc(Issue)
class Issue: NSManagedObject {

}

extension Issue {

    @nonobjc class func fetchRequest() -> NSFetchRequest<Issue> {
        return NSFetchRequest<Issue>(entityName: "Issue")
    }

    @NSManaged var age: Int32
    @NSManaged var documentFilePath: String?
    @NSManaged var documentLocationData: String?
    @NSManaged var fixItType: String?
    @NSManaged var identifier: String?
    @NSManaged var issueType: String?
    @NSManaged var lineNumber: Int32
    @NSManaged var message: String?
    @NSManaged var statusRawValue: Int16
    @NSManaged var target: String?
    @NSManaged var testCase: String?
    @NSManaged var typeRawValue: String?
    @NSManaged var inverseBuildServiceErrors: IntegrationIssues?
    @NSManaged var inverseBuildServiceWarnings: IntegrationIssues?
    @NSManaged var inverseFreshAnalyzerWarnings: IntegrationIssues?
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

extension Issue {
    static func issue(_ id: XcodeServer.Issue.ID, in context: NSManagedObjectContext) -> Issue? {
        let request = NSFetchRequest<Issue>(entityName: entityName)
        request.predicate = NSPredicate(format: "identifier = %@", argumentArray: [id])
        do {
            return try context.fetch(request).first
        } catch {
            InternalLog.coreData.error("Failed to fetch issue '\(id)'", error: error)
        }
        
        return nil
    }
}

extension Issue {
    var status: XcodeServer.Issue.Status {
        get {
            return XcodeServer.Issue.Status(rawValue: Int(statusRawValue)) ?? .new
        }
        set {
            statusRawValue = Int16(newValue.rawValue)
        }
    }
    
    var type: XcodeServer.Issue.Category {
        get {
            return XcodeServer.Issue.Category(rawValue: typeRawValue ?? "") ?? .unknown
        } set {
            typeRawValue = newValue.rawValue
        }
    }
}

extension Issue {
    func update(_ issue: XcodeServer.Issue, context: NSManagedObjectContext) {
        identifier = issue.id
        age = Int32(issue.age)
        documentFilePath = issue.documentFilePath
        documentLocationData = issue.documentLocationData
        fixItType = issue.fixItType
        lineNumber = Int32(issue.lineNumber)
        message = issue.message
        status = issue.status
        target = issue.target
        testCase = issue.testCase
        type = issue.type
    }
}

extension XcodeServer.Issue {
    init(_ issue: Issue) {
        self.init(id: issue.identifier ?? "")
        age = Int(issue.age)
        documentFilePath = issue.documentFilePath ?? ""
        fixItType = issue.fixItType ?? ""
        status = issue.status
        type = issue.type
        lineNumber = Int(issue.lineNumber)
        message = issue.message ?? ""
        testCase = issue.testCase ?? ""
    }
}
#endif
