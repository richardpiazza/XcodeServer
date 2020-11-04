import XcodeServer
#if canImport(CoreData)

public extension XcodeServer.Integration {
    init(_ integration: XcodeServerCoreData.Integration) {
        self.init(id: integration.identifier ?? "")
        number = Int(integration.number)
        step = integration.currentStep
        shouldClean = integration.shouldClean
        queued = integration.queuedDate
        started = integration.startedTime
        ended = integration.endedTime
        duration = integration.duration
        result = integration.result
        successStreak = Int(integration.successStreak)
        testHierarchy = integration.testHierarchy
        botId = integration.bot?.identifier
        botName = integration.bot?.name
        serverId = integration.bot?.server?.fqdn
        
        if let summary = integration.buildResultSummary {
            buildSummary = XcodeServer.Integration.BuildSummary(summary)
        }
        if let assets = integration.assets {
            self.assets = AssetCatalog(assets)
        }
        if let issues = integration.issues {
            self.issues = IssueCatalog(issues)
        }
        
        commits = Set(integration.commits.map({ SourceControl.Commit($0) }))
        
        shouldRetrieveArchive = !integration.hasRetrievedAssets
        shouldRetrieveIssues = !integration.hasRetrievedIssues
        shouldRetrieveCommits = !integration.hasRetrievedCommits
    }
}

public extension XcodeServer.Integration.BuildSummary {
    init(_ summary: BuildResultSummary) {
        self.init()
        errorCount = Int(summary.errorCount)
        errorChange = Int(summary.errorChange)
        warningCount = Int(summary.warningCount)
        warningChange = Int(summary.warningChange)
        testsCount = Int(summary.testsCount)
        testsChange = Int(summary.testsChange)
        testFailureCount = Int(summary.testFailureCount)
        testFailureChange = Int(summary.testFailureChange)
        analyzerWarningCount = Int(summary.analyzerWarningCount)
        analyzerWarningChange = Int(summary.analyzerWarningChange)
        regressedPerfTestCount = Int(summary.regressedPerfTestCount)
        improvedPerfTestCount = Int(summary.improvedPerfTestCount)
        codeCoveragePercentage = Int(summary.codeCoveragePercentage)
        codeCoveragePercentageDelta = Int(summary.codeCoveragePercentageDelta)
    }
}

public extension XcodeServer.Integration.AssetCatalog {
    init(_ assets: IntegrationAssets) {
        self.init()
        if let asset = assets.triggerAssets as? Set<Asset> {
            triggerAssets = asset.map { XcodeServer.Integration.Asset($0) }
        }
        if let asset = assets.sourceControlLog {
            sourceControlLog = XcodeServer.Integration.Asset(asset)
        }
        if let asset = assets.buildServiceLog {
            buildServiceLog = XcodeServer.Integration.Asset(asset)
        }
        if let asset = assets.xcodebuildLog {
            xcodebuildLog = XcodeServer.Integration.Asset(asset)
        }
        if let asset = assets.xcodebuildOutput {
            xcodebuildOutput = XcodeServer.Integration.Asset(asset)
        }
        if let asset = assets.archive {
            archive = XcodeServer.Integration.Asset(asset)
        }
        if let asset = assets.product {
            product = XcodeServer.Integration.Asset(asset)
        }
    }
}

public extension XcodeServer.Integration.Asset {
    init(_ asset: Asset) {
        self.init()
        size = Int(asset.size)
        fileName = asset.fileName ?? ""
        relativePath = asset.relativePath ?? ""
        triggerName = asset.triggerName ?? ""
        allowAnonymousAccess = asset.allowAnonymousAccess
        isDirectory = asset.isDirectory
    }
}

public extension XcodeServer.Integration.IssueCatalog {
    init(_ issues: XcodeServerCoreData.IntegrationIssues) {
        self.init()
        if let value = issues.buildServiceErrors as? Set<Issue> {
            buildServiceErrors = Set(value.map { XcodeServer.Issue($0) })
        }
        if let value = issues.buildServiceWarnings as? Set<Issue> {
            buildServiceWarnings = Set(value.map { XcodeServer.Issue($0) })
        }
        if let value = issues.freshErrors as? Set<Issue> {
            errors.freshIssues = Set(value.map { XcodeServer.Issue($0) })
        }
        if let value = issues.freshWarnings as? Set<Issue> {
            warnings.freshIssues = Set(value.map { XcodeServer.Issue($0) })
        }
        if let value = issues.freshTestFailures as? Set<Issue> {
            testFailures.freshIssues = Set(value.map { XcodeServer.Issue($0) })
        }
        if let value = issues.freshAnalyzerWarnings as? Set<Issue> {
            analyzerWarnings.freshIssues = Set(value.map { XcodeServer.Issue($0) })
        }
        if let value = issues.resolvedErrors as? Set<Issue> {
            errors.resolvedIssues = Set(value.map { XcodeServer.Issue($0) })
        }
        if let value = issues.resolvedWarnings as? Set<Issue> {
            warnings.resolvedIssues = Set(value.map { XcodeServer.Issue($0) })
        }
        if let value = issues.resolvedTestFailures as? Set<Issue> {
            testFailures.resolvedIssues = Set(value.map { XcodeServer.Issue($0) })
        }
        if let value = issues.resolvedAnalyzerWarnings as? Set<Issue> {
            analyzerWarnings.resolvedIssues = Set(value.map { XcodeServer.Issue($0) })
        }
        if let value = issues.unresolvedErrors as? Set<Issue> {
            errors.unresolvedIssues = Set(value.map { XcodeServer.Issue($0) })
        }
        if let value = issues.unresolvedWarnings as? Set<Issue> {
            warnings.unresolvedIssues = Set(value.map { XcodeServer.Issue($0) })
        }
        if let value = issues.unresolvedTestFailures as? Set<Issue> {
            testFailures.unresolvedIssues = Set(value.map { XcodeServer.Issue($0) })
        }
        if let value = issues.unresolvedAnalyzerWarnings as? Set<Issue> {
            analyzerWarnings.unresolvedIssues = Set(value.map { XcodeServer.Issue($0) })
        }
        
        // Model 1.1.0
        if let value = issues.primitiveValue(forKey: #keyPath(IntegrationIssues.triggerErrors)) as? Set<Issue> {
            triggerErrors = Set(value.map({ XcodeServer.Issue($0) }))
        }
    }
}

#endif
