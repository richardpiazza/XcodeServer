import XcodeServer
import Foundation

public extension Integration {
    init(_ integration: XCSIntegration, bot: Bot.ID?, server: Server.ID?) {
        self.init(id: integration.id)
        number = Int(integration.number)
        step = Integration.Step(rawValue: integration.currentStep.rawValue) ?? .pending
        shouldClean = integration.shouldClean ?? false
        queued = integration.queuedDate
        started = integration.startedTime
        ended = integration.endedTime
        duration = integration.duration
        result = Integration.Result(rawValue: integration.result.rawValue) ?? .unknown
        successStreak = (integration.successStreak != nil) ? Int(integration.successStreak!) : 0
        codeCoverage = (integration.ccPercentage != nil) ? Int(integration.ccPercentage!) : 0
        coverageDelta = (integration.ccPercentageDelta != nil) ? Int(integration.ccPercentageDelta!) : 0
        if let tests = integration.testHierarchy {
            testHierarchy = Tests.Hierarchy(tests)
        }
        if let summary = integration.buildResultSummary {
            buildSummary = BuildSummary(summary)
        }
        if let blueprint = integration.revisionBlueprint {
            revisionBlueprint = SourceControl.Blueprint(blueprint)
        }
        if let catalog = integration.assets {
            assets = AssetCatalog(catalog)
        }
        botId = bot
        serverId = server
    }
    
    init(_ snippet: XCSIntegrationSnippet) {
        self.init(id: snippet.id)
        ended = snippet.endedTime
        successStreak = snippet.successStreak ?? 0
    }
}

public extension Integration.BuildSummary {
    init(_ summary: XCSBuildResultSummary) {
        self.init()
        errorCount = summary.errorCount
        errorChange = summary.errorChange
        warningCount = summary.warningCount
        warningChange = summary.warningChange
        testsCount = summary.testsCount
        testsChange = summary.testsChange
        testFailureCount = summary.testFailureCount
        testFailureChange = summary.testFailureChange
        analyzerWarningCount = summary.analyzerWarningCount
        analyzerWarningChange = summary.analyzerWarningChange
        regressedPerfTestCount = summary.regressedPerfTestCount
        improvedPerfTestCount = summary.improvedPerfTestCount
        codeCoveragePercentage = summary.codeCoveragePercentage
        codeCoveragePercentageDelta = summary.codeCoveragePercentageDelta
    }
}

public extension Integration.ControlledChanges {
    init(_ changes: XCSControlledChanges) {
        self.init()
        if let traits = changes.xcode {
            xcode = Integration.ControlledChanges.Traits(traits)
        }
        if let platforms = changes.platforms {
            self.platforms = Platforms(platforms)
        }
    }
}

public extension Integration.ControlledChanges.Values {
    init(_ values: XCSControlledChangeValues) {
        self.init()
        before = values.before ?? ""
        after = values.after ?? ""
    }
}

public extension Integration.ControlledChanges.Traits {
    init(_ traits: XCSControlledChangeTraits) {
        self.init()
        if let values = traits.version {
            version = Integration.ControlledChanges.Values(values)
        }
        if let values = traits.buildNumber {
            buildNumber = Integration.ControlledChanges.Values(values)
        }
    }
}

public extension Integration.ControlledChanges.Platforms {
    init(_ platforms: XCSControlledChangePlatforms) {
        self.init()
        if let values = platforms.macOS {
            macOS = Integration.ControlledChanges.Traits(values)
        }
        if let values = platforms.iOS {
            iOS = Integration.ControlledChanges.Traits(values)
        }
        if let values = platforms.tvOS {
            tvOS = Integration.ControlledChanges.Traits(values)
        }
        if let values = platforms.watchOS {
            watchOS = Integration.ControlledChanges.Traits(values)
        }
    }
}

public extension Integration.AssetCatalog {
    init(_ assets: XCSAssets) {
        self.init()
        if let asset = assets.triggerAssets {
            triggerAssets = asset.map { Integration.Asset($0) }
        }
        if let asset = assets.sourceControlLog {
            sourceControlLog = Integration.Asset(asset)
        }
        if let asset = assets.buildServiceLog {
            buildServiceLog = Integration.Asset(asset)
        }
        if let asset = assets.xcodebuildLog {
            xcodebuildLog = Integration.Asset(asset)
        }
        if let asset = assets.xcodebuildOutput {
            xcodebuildOutput = Integration.Asset(asset)
        }
        if let asset = assets.archive {
            archive = Integration.Asset(asset)
        }
        if let asset = assets.product {
            product = Integration.Asset(asset)
        }
    }
}

public extension Integration.Asset {
    init(_ asset: XCSIntegrationAsset) {
        self.init()
        size = asset.size ?? 0
        fileName = asset.fileName ?? ""
        relativePath = asset.relativePath ?? ""
        triggerName = asset.triggerName ?? ""
        allowAnonymousAccess = asset.allowAnonymousAccess ?? false
        isDirectory = asset.isDirectory ?? false
    }
}

public extension Integration.IssueCatalog {
    init(_ issues: XCSIssues, integration: Integration.ID?) {
        self.init()
        if let value = issues.buildServiceErrors {
            buildServiceErrors = Set(value.map { Issue($0, integration: integration) })
        }
        if let value = issues.buildServiceWarnings {
            buildServiceWarnings = Set(value.map { Issue($0, integration: integration) })
        }
        if let value = issues.triggerErrors {
            triggerErrors = Set(value.map { Issue($0, integration: integration) })
        }
        if let group = issues.errors {
            errors = Integration.IssueGroup(group, integration: integration)
        }
        if let group = issues.warnings {
            warnings = Integration.IssueGroup(group, integration: integration)
        }
        if let group = issues.testFailures {
            testFailures = Integration.IssueGroup(group, integration: integration)
        }
        if let group = issues.analyzerWarnings {
            analyzerWarnings = Integration.IssueGroup(group, integration: integration)
        }
    }
}

public extension Integration.IssueGroup {
    init(_ group: XCSIssueGroup, integration: Integration.ID?) {
        self.init()
        freshIssues = Set(group.freshIssues.map { Issue($0, integration: integration) })
        resolvedIssues = Set(group.resolvedIssues.map { Issue($0, integration: integration) })
        unresolvedIssues = Set(group.unresolvedIssues.map { Issue($0, integration: integration) })
        silencedIssues = Set(group.silencedIssues.map { Issue($0, integration: integration) })
    }
}
