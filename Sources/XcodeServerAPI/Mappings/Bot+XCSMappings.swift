import XcodeServer
import Foundation

public extension Bot {
    init(_ bot: XCSBot) {
        self.init(id: bot.id)
        name = bot.name
        nextIntegrationNumber = bot.nextIntegrationNumber
        type = bot.type
        requiresUpgrade = bot.requiresUpgrade
        if let configuration = bot.configuration {
            self.configuration = Configuration(configuration)
        }
        if let blueprint = bot.sourceControlBlueprint {
            sourceControlBlueprint = SourceControl.Blueprint(blueprint)
        }
        if let blueprint = bot.lastRevisionBlueprint {
            lastRevisionBlueprint = SourceControl.Blueprint(blueprint)
        }
    }
}

public extension Bot.Configuration {
    init(_ configuration: XCSConfiguration) {
        self.init()
        schedule = Bot.Schedule(rawValue: configuration.scheduleType?.rawValue ?? 0) ?? .manual
        periodicInterval = Bot.PeriodicInterval(rawValue: configuration.periodicScheduleInterval.rawValue) ?? .none
        weeklyScheduleDay = configuration.weeklyScheduleDay ?? 0
        hourOfIntegration = configuration.hourOfIntegration ?? 0
        minutesAfterHourToIntegrate = configuration.minutesAfterHourToIntegrate ?? 0
        schemeName = configuration.schemeName ?? ""
        cleaning = Bot.Cleaning(rawValue: configuration.builtFromClean?.rawValue ?? 0) ?? .never
        disableAppThinning = configuration.disableAppThinning ?? false
        coverage = Bot.Coverage(rawValue: configuration.codeCoveragePreference?.rawValue ?? 0) ?? .useSchemeSetting
        useParallelDevices = configuration.useParallelDeviceTesting ?? false
        performsArchive = configuration.performsArchiveAction ?? false
        performsAnalyze = configuration.performsAnalyzeAction ?? false
        performsTest = configuration.performsTestAction ?? false
        performsUpgradeIntegration = configuration.performsUpgradeIntegration ?? false
        exportsProduct = configuration.exportsProductFromArchive ?? false
        runOnlyDisabledTests = configuration.runOnlyDisabledTests ?? false
        buildArguments = configuration.additionalBuildArguments ?? []
        environmentVariables = configuration.buildEnvironmentVariables ?? [:]
        if let options = configuration.archiveExportOptions {
            archiveExportOptions = Bot.Configuration.ArchiveExport(options)
        }
        if let provisioning = configuration.provisioningConfiguration {
            self.provisioning = Provisioning(provisioning)
        }
        if let blueprint = configuration.sourceControlBlueprint {
            sourceControlBlueprint = SourceControl.Blueprint(blueprint)
        }
        if let specification = configuration.deviceSpecification {
            deviceSpecification = Device.Specification(specification)
        }
        if let triggers = configuration.triggers {
            self.triggers = triggers.map { Trigger($0) }
        }
    }
}

public extension Bot.Configuration.Provisioning {
    init(_ provisioning: XCSProvisioningConfiguration) {
        self.init()
        addMissingDevicesToTeams = provisioning.addMissingDevicesToTeams
        manageCertsAndProfiles = provisioning.manageCertsAndProfiles
    }
}

public extension Bot.Configuration.ArchiveExport {
    init(_ export: XCSArchiveExportOptions) {
        self.init()
        created = APIClient.dateFormatter.date(from: export.createdAt ?? "") ?? Date()
        if let options = export.exportOptions {
            self.options = Bot.Configuration.ExportOptions(options)
        }
    }
}

public extension Bot.Configuration.ExportOptions {
    init(_ options: XCSExportOptions) {
        self.init()
        method = options.method ?? ""
        teamID = options.teamID ?? ""
        uploadBitcode = options.uploadBitcode ?? false
        stripSwiftSymbols = options.stripSwiftSymbols ?? false
        iCloudContainerEnvironment = options.iCloudContainerEnvironment ?? ""
        signingCertificate = options.signingCertificate ?? ""
        signingStyle = options.signingStyle ?? ""
        uploadSymbols = options.uploadSymbols ?? false
        provisioningProfiles = options.provisioningProfiles ?? [:]
    }
}

public extension Bot.Stats {
    init(_ stats: XCSStats) {
        self.init()
        commits = stats.numberOfCommits ?? 0
        integrations = stats.numberOfIntegrations ?? 0
        successfulIntegrations = stats.numberOfSuccessfulIntegrations ?? 0
        coverageDelta = stats.codeCoveragePercentageDelta ?? 0
        testAdditionRate = stats.testAdditionRate ?? 0
        sinceDate = stats.sinceDate ?? Date()
        if let summary = stats.analysisWarnings {
            analysisWarnings = Analysis(summary)
        }
        if let summary = stats.averageIntegrationTime {
            averageIntegrationTime = Analysis(summary)
        }
        if let summary = stats.errors {
            errors = Analysis(summary)
        }
        if let summary = stats.improvedPerfTests {
            improvedPerformanceTests = Analysis(summary)
        }
        if let summary = stats.regressedPerfTests {
            regressedPerformanceTests = Analysis(summary)
        }
        if let summary = stats.testFailures {
            testFailures = Analysis(summary)
        }
        if let summary = stats.tests {
            tests = Analysis(summary)
        }
        if let summary = stats.warnings {
            warnings = Analysis(summary)
        }
        if let snippet = stats.bestSuccessStreak {
            bestSuccessStreak = Integration(snippet)
        }
        if let snippet = stats.lastCleanIntegration {
            lastCleanIntegration = Integration(snippet)
        }
    }
}

public extension Bot.Stats.Analysis {
    init(_ summary: XCSStatsSummary) {
        self.init()
        count = summary.count
        sum = summary.sum
        min = summary.min
        max = summary.max
        average = summary.avg
        sumOfSquares = summary.sumsqr ?? 0.0
        standardDeviation = summary.stdDev
    }
}
