import XcodeServer
#if canImport(CoreData)
import CoreData

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

public extension XcodeServerCoreData.Issue {
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

/*
 extension XcodeServerCoreData.Issue {
     public func update(withIssue issue: XCSIssue) {
         self.age = Int32(issue.age ?? 0)
         self.documentFilePath = issue.documentFilePath
         self.documentLocationData = issue.documentLocationData
         self.fixItType = issue.fixItType
         self.issueType = issue.issueType
         self.lineNumber = Int32(issue.lineNumber ?? 0)
         self.message = issue.message
         self.status = XcodeServer.Issue.Status(rawValue: Int(issue.status?.rawValue ?? 0)) ?? .new
         self.testCase = issue.testCase
         self.type = XcodeServer.Issue.Category(rawValue: issue.type?.rawValue ?? "") ?? .unknown
     }
 }
 */

#endif
