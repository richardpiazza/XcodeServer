import XcodeServer

public extension Issue {
    init(_ issue: XCSIssue, integration: Integration.ID?) {
        self.init(id: issue.id)
        age = issue.age ?? 0
        documentFilePath = issue.documentFilePath ?? ""
        fixItType = issue.fixItType ?? ""
        status = Issue.Status(rawValue: issue.status?.rawValue ?? 0) ?? .new
        type = Issue.Category(rawValue: issue.type?.rawValue ?? "") ?? .unknown
        lineNumber = issue.lineNumber ?? 0
        message = issue.message ?? ""
        testCase = issue.testCase ?? ""
        if let commits = issue.commits {
            self.commits = Set(commits.map { SourceControl.Commit($0, integration: integration) })
        }
        integrationId = integration
    }
}
