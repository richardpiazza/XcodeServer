import XcodeServer
import XcodeServerCoreData
import Foundation
#if canImport(CoreData)
import CoreData

//@objc(Issue)
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

public extension Issue {
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

public extension Issue {
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

public extension Issue {
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

public extension XcodeServer.Issue {
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
