import XcodeServer

public extension Issue {
    init(_ issue: XCSIssue, integration: Integration.ID?) {
        self.init(id: issue.id)
        age = issue.age ?? 0
        documentFilePath = issue.documentFilePath ?? ""
        fixItType = issue.fixItType ?? ""
        status = Issue.Status(rawValue: issue.status?.rawValue ?? 0) ?? .new
        type = Issue.Category(rawValue: issue.type?.rawValue ?? "") ?? .unknown
        extendedType = issue.issueType ?? ""
        lineNumber = issue.lineNumber ?? 0
        message = issue.message ?? ""
        testCase = issue.testCase ?? ""
        if let commits = issue.commits {
            self.commits = Set(commits.commits(remote: nil, integration: integration))
        }
        if let authors = issue.issueAuthors {
            self.authors = authors.map({ Issue.Author($0) })
        }
        integrationId = integration
    }
}

public extension Issue.Author {
    init(_ author: XCSIssueAuthor) {
        self.init()
        commitId = author.commitHash ?? ""
        remoteId = author.blueprintRepository ?? ""
        if let strategy = author.suspectStrategy {
            suspectStrategy = Issue.SuspectStrategy(strategy)
        }
    }
}

public extension Issue.SuspectStrategy {
    init(_ strategy: XCSSuspectStrategy) {
        self.init()
        confidence = Confidence(rawValue: strategy.confidence?.rawValue ?? 0) ?? .low
        reliability = strategy.reliability ?? 0
        identificationStrategy = IdentificationStrategy(rawValue: strategy.identificationStrategy?.rawValue ?? 0) ?? .blameLineAgainstCommits
    }
}
