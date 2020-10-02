import XcodeServer
#if canImport(CoreData)

public extension XcodeServer.Issue {
    init(_ issue: XcodeServerCoreData.Issue) {
        self.init(id: issue.identifier)
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