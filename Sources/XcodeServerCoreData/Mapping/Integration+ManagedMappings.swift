import XcodeServer
#if canImport(CoreData)

public extension XcodeServer.Integration {
    init(_ integration: XcodeServerCoreData.Integration) {
        self.init(id: integration.identifier)
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
        if let summary = integration.buildResultSummary {
            buildSummary = XcodeServer.Integration.BuildSummary(summary)
        }
        if let assets = integration.assets {
            self.assets = AssetCatalog(assets)
        }
        if let issues = integration.issues {
            self.issues = IssueCatalog(issues)
        }
        commits = Set(integration.commits.map { SourceControl.Commit($0) })
        botId = integration.bot?.identifier
        serverId = integration.bot?.server?.fqdn
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
        if let asset = assets.triggerAssets {
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
        if let value = issues.buildServiceErrors {
            buildServiceErrors = Set(value.map { XcodeServer.Issue($0) })
        }
        if let value = issues.buildServiceWarnings {
            buildServiceWarnings = Set(value.map { XcodeServer.Issue($0) })
        }
        if let value = issues.freshErrors {
            errors.freshIssues = Set(value.map { XcodeServer.Issue($0) })
        }
        if let value = issues.freshWarnings {
            warnings.freshIssues = Set(value.map { XcodeServer.Issue($0) })
        }
        if let value = issues.freshTestFailures {
            testFailures.freshIssues = Set(value.map { XcodeServer.Issue($0) })
        }
        if let value = issues.freshAnalyzerWarnings {
            analyzerWarnings.freshIssues = Set(value.map { XcodeServer.Issue($0) })
        }
        if let value = issues.resolvedErrors {
            errors.resolvedIssues = Set(value.map { XcodeServer.Issue($0) })
        }
        if let value = issues.resolvedWarnings {
            warnings.resolvedIssues = Set(value.map { XcodeServer.Issue($0) })
        }
        if let value = issues.resolvedTestFailures {
            testFailures.resolvedIssues = Set(value.map { XcodeServer.Issue($0) })
        }
        if let value = issues.resolvedAnalyzerWarnings {
            analyzerWarnings.resolvedIssues = Set(value.map { XcodeServer.Issue($0) })
        }
        if let value = issues.unresolvedErrors {
            errors.unresolvedIssues = Set(value.map { XcodeServer.Issue($0) })
        }
        if let value = issues.unresolvedWarnings {
            warnings.unresolvedIssues = Set(value.map { XcodeServer.Issue($0) })
        }
        if let value = issues.unresolvedTestFailures {
            testFailures.unresolvedIssues = Set(value.map { XcodeServer.Issue($0) })
        }
        if let value = issues.unresolvedAnalyzerWarnings {
            analyzerWarnings.unresolvedIssues = Set(value.map { XcodeServer.Issue($0) })
        }
    }
}

#endif
