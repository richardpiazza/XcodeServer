import XcodeServer
import Foundation
#if canImport(CoreData)

public extension XcodeServer.Bot {
    init(_ bot: XcodeServerCoreData.Bot) {
        self.init(id: bot.identifier)
        modified = bot.lastUpdate ?? Date()
        name = bot.name ?? ""
        nextIntegrationNumber = Int(bot.integrationCounter)
        type = Int(bot.typeRawValue)
        requiresUpgrade = bot.requiresUpgrade
        serverId = bot.server?.fqdn
        if let config = bot.configuration {
            configuration = Configuration(config)
        }
        if let stats = bot.stats {
            self.stats = Stats(stats)
        }
        if let integrations = bot.integrations {
            self.integrations = Set(integrations.map { XcodeServer.Integration($0) })
        }
    }
}

public extension XcodeServer.Bot.Configuration {
    init(_ configuration: XcodeServerCoreData.Configuration) {
        self.init()
        schedule = configuration.scheduleType
        periodicInterval = configuration.periodicScheduleInterval
        weeklyScheduleDay = Int(configuration.weeklyScheduleDay)
        hourOfIntegration = Int(configuration.hourOfIntegration)
        minutesAfterHourToIntegrate = Int(configuration.minutesAfterHourToIntegrate)
        schemeName = configuration.schemeName ?? ""
        cleaning = configuration.cleanSchedule
        disableAppThinning = configuration.disableAppThinning
        coverage = configuration.codeCoveragePreference
        useParallelDevices = configuration.useParallelDeviceTesting
        performsArchive = configuration.performsArchiveAction
        performsAnalyze = configuration.performsAnalyzeAction
        performsTest = configuration.performsTestAction
        performsUpgradeIntegration = configuration.performsUpgradeIntegration
        exportsProduct = configuration.exportsProductFromArchive
        runOnlyDisabledTests = configuration.runOnlyDisabledTests
        buildArguments = configuration.additionalBuildArguments
        environmentVariables = configuration.buildEnvironmentVariables
        provisioning = configuration.provisioning
        if let specification = configuration.deviceSpecification {
            deviceSpecification = XcodeServer.Device.Specification(specification)
        }
        if let triggers = configuration.triggers {
            self.triggers = triggers.map { XcodeServer.Trigger($0) }
        }
    }
}

public extension XcodeServer.Bot.Stats {
    init(_ stats: XcodeServerCoreData.Stats) {
        self.init()
        commits = Int(stats.numberOfCommits)
        integrations = Int(stats.numberOfIntegrations)
        successfulIntegrations = Int(stats.numberOfSuccessfulIntegrations)
        coverageDelta = Int(stats.codeCoveragePercentageDelta)
        testAdditionRate = Int(stats.testAdditionRate)
        sinceDate = stats.since
        if let breakdown = stats.analysisWarnings {
            analysisWarnings = Analysis(breakdown)
        }
        if let breakdown = stats.averageIntegrationTime {
            averageIntegrationTime = Analysis(breakdown)
        }
        if let breakdown = stats.errors {
            errors = Analysis(breakdown)
        }
        if let breakdown = stats.improvedPerfTests {
            improvedPerformanceTests = Analysis(breakdown)
        }
        if let breakdown = stats.regressedPerfTests {
            regressedPerformanceTests = Analysis(breakdown)
        }
        if let breakdown = stats.testFailures {
            testFailures = Analysis(breakdown)
        }
        if let breakdown = stats.tests {
            tests = Analysis(breakdown)
        }
        if let breakdown = stats.warnings {
            warnings = Analysis(breakdown)
        }
        if let integration = stats.bestSuccessStreak {
            bestSuccessStreak = XcodeServer.Integration(integration)
        }
        if let integration = stats.lastCleanIntegration {
            lastCleanIntegration = XcodeServer.Integration(integration)
        }
    }
}

public extension XcodeServer.Bot.Stats.Analysis {
    init(_ breakdown: StatsBreakdown) {
        self.init()
        count = Int(breakdown.count)
        sum = breakdown.sum
        min = breakdown.min
        max = breakdown.max
        average = breakdown.avg
        standardDeviation = breakdown.stdDev
    }
}

#endif
