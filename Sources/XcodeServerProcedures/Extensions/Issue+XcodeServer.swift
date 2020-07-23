import Foundation
import XcodeServerCommon
import XcodeServerAPI
#if canImport(CoreData)
import XcodeServerCoreData

extension Issue {
    public func update(withIssue issue: XCSIssue) {
        self.age = Int32(issue.age ?? 0)
        self.documentFilePath = issue.documentFilePath
        self.documentLocationData = issue.documentLocationData
        self.fixItType = issue.fixItType
        self.issueType = issue.issueType
        self.lineNumber = Int32(issue.lineNumber ?? 0)
        self.message = issue.message
        self.status = IssueStatus(rawValue: Int16(issue.status?.rawValue ?? 0)) ?? .new
        self.testCase = issue.testCase
        self.type = IssueType(rawValue: issue.type?.rawValue ?? "") ?? .unknown
    }
}

#endif
