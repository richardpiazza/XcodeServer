import Foundation
#if canImport(CoreData)
import CoreData

/// Xcode Server Core Data Model: **1.1.0**
///
/// This represents a small tweak to the base model, primarily to ensure the migration process.
///
/// ## Additions
///
/// * `IntegrationIssues.triggerErrors`: Trigger errors can occur and are available through the api. The original model
///   did not account for these, so some Integrations could potentially report no errors.
///
/// ## Transformations
///
/// _N/A_
///
/// ## Removals
///
/// _N/A_
///
class Model_1_1_0: NSManagedObjectModel {
    
    internal override init() {
        super.init()
        
        let asset = NSEntityDescription(name: "Asset")
        asset.properties.append(NSAttributeDescription(name: "allowAnonymousAccess", type: .booleanAttributeType, defaultValue: false))
        asset.properties.append(NSAttributeDescription(name: "fileName", type: .stringAttributeType))
        asset.properties.append(NSAttributeDescription(name: "isDirectory", type: .booleanAttributeType, defaultValue: false))
        asset.properties.append(NSAttributeDescription(name: "relativePath", type: .stringAttributeType))
        asset.properties.append(NSAttributeDescription(name: "size", type: .integer32AttributeType, defaultValue: 0))
        asset.properties.append(NSAttributeDescription(name: "triggerName", type: .stringAttributeType))
        
        let bot = NSEntityDescription(name: "Bot")
        let bot_identifier = NSAttributeDescription(name: "identifier", type: .stringAttributeType, isOptional: false, defaultValue: "f8cf876e03804ea585fe6cb54bcca396")
        let bot_name = NSAttributeDescription(name: "name", type: .stringAttributeType)
        bot.properties.append(bot_identifier)
        bot.properties.append(NSAttributeDescription(name: "integrationCounter", type: .integer32AttributeType, defaultValue: 0))
        bot.properties.append(NSAttributeDescription(name: "lastUpdate", type: .dateAttributeType))
        bot.properties.append(bot_name)
        bot.properties.append(NSAttributeDescription(name: "requiresUpgrade", type: .booleanAttributeType, defaultValue: false))
        bot.properties.append(NSAttributeDescription(name: "typeRawValue", type: .integer16AttributeType, defaultValue: 0))
        
        bot.indexes.append(NSFetchIndexDescription(name: "byPropertyIndex", elements: [
            NSFetchIndexElementDescription(property: bot_identifier, collationType: .binary),
            NSFetchIndexElementDescription(property: bot_name, collationType: .binary)
            ]))
        
        let buildResultSummary = NSEntityDescription(name: "BuildResultSummary")
        buildResultSummary.properties.append(NSAttributeDescription(name: "analyzerWarningChange", type: .integer32AttributeType, defaultValue: 0))
        buildResultSummary.properties.append(NSAttributeDescription(name: "analyzerWarningCount", type: .integer32AttributeType, defaultValue: 0))
        buildResultSummary.properties.append(NSAttributeDescription(name: "codeCoveragePercentage", type: .integer32AttributeType, defaultValue: 0))
        buildResultSummary.properties.append(NSAttributeDescription(name: "codeCoveragePercentageDelta", type: .integer32AttributeType, defaultValue: 0))
        buildResultSummary.properties.append(NSAttributeDescription(name: "errorChange", type: .integer32AttributeType, defaultValue: 0))
        buildResultSummary.properties.append(NSAttributeDescription(name: "errorCount", type: .integer32AttributeType, defaultValue: 0))
        buildResultSummary.properties.append(NSAttributeDescription(name: "improvedPerfTestCount", type: .integer32AttributeType, defaultValue: 0))
        buildResultSummary.properties.append(NSAttributeDescription(name: "regressedPerfTestCount", type: .integer32AttributeType, defaultValue: 0))
        buildResultSummary.properties.append(NSAttributeDescription(name: "testFailureChange", type: .integer32AttributeType, defaultValue: 0))
        buildResultSummary.properties.append(NSAttributeDescription(name: "testFailureCount", type: .integer32AttributeType, defaultValue: 0))
        buildResultSummary.properties.append(NSAttributeDescription(name: "testsChange", type: .integer32AttributeType, defaultValue: 0))
        buildResultSummary.properties.append(NSAttributeDescription(name: "testsCount", type: .integer32AttributeType, defaultValue: 0))
        buildResultSummary.properties.append(NSAttributeDescription(name: "warningChange", type: .integer32AttributeType, defaultValue: 0))
        buildResultSummary.properties.append(NSAttributeDescription(name: "warningCount", type: .integer32AttributeType, defaultValue: 0))
        
        let commit = NSEntityDescription(name: "Commit")
        let commit_commitHash = NSAttributeDescription(name: "commitHash", type: .stringAttributeType, isOptional: false, defaultValue: "_commitHash")
        commit.properties.append(commit_commitHash)
        commit.properties.append(NSAttributeDescription(name: "message", type: .stringAttributeType))
        commit.properties.append(NSAttributeDescription(name: "date", type: .dateAttributeType))
        
        commit.indexes.append(NSFetchIndexDescription(name: "byPropertyIndex", elements: [
            NSFetchIndexElementDescription(property: commit_commitHash, collationType: .binary)
            ]))
        
        let commitChange = NSEntityDescription(name: "CommitChange")
        commitChange.properties.append(NSAttributeDescription(name: "filePath", type: .stringAttributeType))
        commitChange.properties.append(NSAttributeDescription(name: "statusRawValue", type: .integer16AttributeType, defaultValue: 0))
        
        let commitContributor = NSEntityDescription(name: "CommitContributor")
        commitContributor.properties.append(NSAttributeDescription(name: "displayName", type: .stringAttributeType))
        commitContributor.properties.append(NSAttributeDescription(name: "emailsData", type: .binaryDataAttributeType))
        commitContributor.properties.append(NSAttributeDescription(name: "name", type: .stringAttributeType))
        
        let conditions = NSEntityDescription(name: "Conditions")
        conditions.properties.append(NSAttributeDescription(name: "onAllIssuesResolved", type: .booleanAttributeType, defaultValue: false))
        conditions.properties.append(NSAttributeDescription(name: "onAnalyzerWarnings", type: .booleanAttributeType, defaultValue: false))
        conditions.properties.append(NSAttributeDescription(name: "onBuildErrors", type: .booleanAttributeType, defaultValue: false))
        conditions.properties.append(NSAttributeDescription(name: "onFailingTests", type: .booleanAttributeType, defaultValue: false))
        conditions.properties.append(NSAttributeDescription(name: "onInternalErrors", type: .booleanAttributeType, defaultValue: false))
        conditions.properties.append(NSAttributeDescription(name: "onSuccess", type: .booleanAttributeType, defaultValue: false))
        conditions.properties.append(NSAttributeDescription(name: "onWarnings", type: .booleanAttributeType, defaultValue: false))
        conditions.properties.append(NSAttributeDescription(name: "statusRawValue", type: .integer16AttributeType, defaultValue: 0))
        
        let configuration = NSEntityDescription(name: "Configuration")
        configuration.properties.append(NSAttributeDescription(name: "additionalBuildArgumentsData", type: .binaryDataAttributeType))
        configuration.properties.append(NSAttributeDescription(name: "addMissingDeviceToTeams", type: .booleanAttributeType, defaultValue: false))
        configuration.properties.append(NSAttributeDescription(name: "buildEnvironmentVariablesData", type: .binaryDataAttributeType))
        configuration.properties.append(NSAttributeDescription(name: "codeCoveragePreferenceRawValue", type: .integer16AttributeType, defaultValue: 0))
        configuration.properties.append(NSAttributeDescription(name: "cleanScheduleRawValue", type: .integer16AttributeType, defaultValue: 0))
        configuration.properties.append(NSAttributeDescription(name: "disableAppThinning", type: .booleanAttributeType, defaultValue: false))
        configuration.properties.append(NSAttributeDescription(name: "exportsProductFromArchive", type: .booleanAttributeType, defaultValue: false))
        configuration.properties.append(NSAttributeDescription(name: "hourOfIntegration", type: .integer16AttributeType, defaultValue: 0))
        configuration.properties.append(NSAttributeDescription(name: "manageCertsAndProfiles", type: .booleanAttributeType, defaultValue: false))
        configuration.properties.append(NSAttributeDescription(name: "minutesAfterHourToIntegrate", type: .integer16AttributeType, defaultValue: 0))
        configuration.properties.append(NSAttributeDescription(name: "periodicScheduleIntervalRawValue", type: .integer16AttributeType, defaultValue: 0))
        configuration.properties.append(NSAttributeDescription(name: "performsAnalyzeAction", type: .booleanAttributeType, defaultValue: false))
        configuration.properties.append(NSAttributeDescription(name: "performsArchiveAction", type: .booleanAttributeType, defaultValue: false))
        configuration.properties.append(NSAttributeDescription(name: "performsTestAction", type: .booleanAttributeType, defaultValue: false))
        configuration.properties.append(NSAttributeDescription(name: "performsUpgradeIntegration", type: .booleanAttributeType, defaultValue: false))
        configuration.properties.append(NSAttributeDescription(name: "runOnlyDisabledTests", type: .booleanAttributeType, defaultValue: false))
        configuration.properties.append(NSAttributeDescription(name: "scheduleTypeRawValue", type: .integer16AttributeType, defaultValue: 0))
        configuration.properties.append(NSAttributeDescription(name: "schemeName", type: .stringAttributeType))
        configuration.properties.append(NSAttributeDescription(name: "testingDestinationTypeRawValue", type: .integer16AttributeType, defaultValue: 0))
        configuration.properties.append(NSAttributeDescription(name: "useParallelDeviceTesting", type: .booleanAttributeType, defaultValue: false))
        configuration.properties.append(NSAttributeDescription(name: "weeklyScheduleDay", type: .integer16AttributeType, defaultValue: 0))
        
        
        let device = NSEntityDescription(name: "Device")
        let device_identifier = NSAttributeDescription(name: "identifier", type: .stringAttributeType, isOptional: false, defaultValue: "0a21bee5e97f43cd9aaddaa31eceab29")
        device.properties.append(NSAttributeDescription(name: "architecture", type: .stringAttributeType))
        device.properties.append(NSAttributeDescription(name: "deviceType", type: .stringAttributeType))
        device.properties.append(device_identifier)
        device.properties.append(NSAttributeDescription(name: "isConnected", type: .booleanAttributeType, defaultValue: false))
        device.properties.append(NSAttributeDescription(name: "isEnabledForDevelopment", type: .booleanAttributeType, defaultValue: false))
        device.properties.append(NSAttributeDescription(name: "isRetina", type: .booleanAttributeType, defaultValue: false))
        device.properties.append(NSAttributeDescription(name: "isServer", type: .booleanAttributeType, defaultValue: false))
        device.properties.append(NSAttributeDescription(name: "isSimulator", type: .booleanAttributeType, defaultValue: false))
        device.properties.append(NSAttributeDescription(name: "isSupported", type: .booleanAttributeType, defaultValue: false))
        device.properties.append(NSAttributeDescription(name: "isTrusted", type: .booleanAttributeType, defaultValue: false))
        device.properties.append(NSAttributeDescription(name: "isWireless", type: .booleanAttributeType, defaultValue: false))
        device.properties.append(NSAttributeDescription(name: "modelCode", type: .stringAttributeType))
        device.properties.append(NSAttributeDescription(name: "modelName", type: .stringAttributeType))
        device.properties.append(NSAttributeDescription(name: "modelUTI", type: .stringAttributeType))
        device.properties.append(NSAttributeDescription(name: "name", type: .stringAttributeType))
        device.properties.append(NSAttributeDescription(name: "osVersion", type: .stringAttributeType))
        device.properties.append(NSAttributeDescription(name: "platformIdentifier", type: .stringAttributeType))
        
        device.indexes.append(NSFetchIndexDescription(name: "byPropertyIndex", elements: [
            NSFetchIndexElementDescription(property: device_identifier, collationType: .binary)
            ]))
        
        let deviceSpecification = NSEntityDescription(name: "DeviceSpecification")
        
        let emailConfiguration = NSEntityDescription(name: "EmailConfiguration")
        emailConfiguration.properties.append(NSAttributeDescription(name: "additionalRecipients", type: .stringAttributeType))
        emailConfiguration.properties.append(NSAttributeDescription(name: "allowedDomainNamesData", type: .binaryDataAttributeType))
        emailConfiguration.properties.append(NSAttributeDescription(name: "ccAddressesData", type: .binaryDataAttributeType))
        emailConfiguration.properties.append(NSAttributeDescription(name: "emailCommitters", type: .booleanAttributeType))
        emailConfiguration.properties.append(NSAttributeDescription(name: "emailTypeRawValue", type: .integer16AttributeType))
        emailConfiguration.properties.append(NSAttributeDescription(name: "fromAddress", type: .stringAttributeType))
        emailConfiguration.properties.append(NSAttributeDescription(name: "hour", type: .integer16AttributeType))
        emailConfiguration.properties.append(NSAttributeDescription(name: "includeBotConfiguration", type: .booleanAttributeType))
        emailConfiguration.properties.append(NSAttributeDescription(name: "includeCommitMessages", type: .booleanAttributeType))
        emailConfiguration.properties.append(NSAttributeDescription(name: "includeIssueDetails", type: .booleanAttributeType))
        emailConfiguration.properties.append(NSAttributeDescription(name: "includeLogs", type: .booleanAttributeType))
        emailConfiguration.properties.append(NSAttributeDescription(name: "includeResolvedIssues", type: .booleanAttributeType))
        emailConfiguration.properties.append(NSAttributeDescription(name: "minutesAfterHour", type: .integer16AttributeType))
        emailConfiguration.properties.append(NSAttributeDescription(name: "replyToAddress", type: .stringAttributeType))
        emailConfiguration.properties.append(NSAttributeDescription(name: "weeklyScheduleDay", type: .integer16AttributeType))
        
        let filter = NSEntityDescription(name: "Filter")
        filter.properties.append(NSAttributeDescription(name: "architectureTypeRawValue", type: .integer16AttributeType, defaultValue: 0))
        filter.properties.append(NSAttributeDescription(name: "filterTypeRawValue", type: .integer16AttributeType, defaultValue: 0))
        
        let integration = NSEntityDescription(name: "Integration")
        let integration_identifier = NSAttributeDescription(name: "identifier", type: .stringAttributeType, isOptional: false, defaultValue: "c7f172cb9df24db9bc4e65f609800cbe")
        integration.properties.append(NSAttributeDescription(name: "currentStepRawValue", type: .stringAttributeType))
        integration.properties.append(NSAttributeDescription(name: "duration", type: .doubleAttributeType, defaultValue: 0))
        integration.properties.append(NSAttributeDescription(name: "endedTime", type: .dateAttributeType))
        integration.properties.append(NSAttributeDescription(name: "hasRetrievedAssets", type: .booleanAttributeType))
        integration.properties.append(NSAttributeDescription(name: "hasRetrievedCommits", type: .booleanAttributeType))
        integration.properties.append(NSAttributeDescription(name: "hasRetrievedIssues", type: .booleanAttributeType))
        integration.properties.append(integration_identifier)
        integration.properties.append(NSAttributeDescription(name: "lastUpdate", type: .dateAttributeType))
        integration.properties.append(NSAttributeDescription(name: "number", type: .integer32AttributeType, defaultValue: 0))
        integration.properties.append(NSAttributeDescription(name: "queuedDate", type: .dateAttributeType))
        integration.properties.append(NSAttributeDescription(name: "resultRawValue", type: .stringAttributeType))
        integration.properties.append(NSAttributeDescription(name: "revision", type: .stringAttributeType))
        integration.properties.append(NSAttributeDescription(name: "shouldClean", type: .booleanAttributeType))
        integration.properties.append(NSAttributeDescription(name: "startedTime", type: .dateAttributeType))
        integration.properties.append(NSAttributeDescription(name: "successStreak", type: .integer32AttributeType, defaultValue: 0))
        integration.properties.append(NSAttributeDescription(name: "testHierarchyData", type: .binaryDataAttributeType))
        
        integration.indexes.append(NSFetchIndexDescription(name: "byPropertyIndex", elements: [
            NSFetchIndexElementDescription(property: integration_identifier, collationType: .binary)
            ]))
        
        let integrationAssets = NSEntityDescription(name: "IntegrationAssets")
        
        let integrationIssues = NSEntityDescription(name: "IntegrationIssues")
        
        let issue = NSEntityDescription(name: "Issue")
        let issue_identifier = NSAttributeDescription(name: "identifier", type: .stringAttributeType, isOptional: false, defaultValue: "aa250af67a174b8192a950fabb457776")
        issue.properties.append(NSAttributeDescription(name: "age", type: .integer32AttributeType, defaultValue: 0))
        issue.properties.append(NSAttributeDescription(name: "documentFilePath", type: .stringAttributeType))
        issue.properties.append(NSAttributeDescription(name: "documentLocationData", type: .stringAttributeType))
        issue.properties.append(NSAttributeDescription(name: "fixItType", type: .stringAttributeType))
        issue.properties.append(issue_identifier)
        issue.properties.append(NSAttributeDescription(name: "issueType", type: .stringAttributeType))
        issue.properties.append(NSAttributeDescription(name: "lineNumber", type: .integer32AttributeType, defaultValue: 0))
        issue.properties.append(NSAttributeDescription(name: "message", type: .stringAttributeType))
        issue.properties.append(NSAttributeDescription(name: "statusRawValue", type: .integer16AttributeType, defaultValue: 0))
        issue.properties.append(NSAttributeDescription(name: "target", type: .stringAttributeType))
        issue.properties.append(NSAttributeDescription(name: "testCase", type: .stringAttributeType))
        issue.properties.append(NSAttributeDescription(name: "typeRawValue", type: .stringAttributeType))
        
        issue.indexes.append(NSFetchIndexDescription(name: "byPropertyIndex", elements: [
            NSFetchIndexElementDescription(property: issue_identifier, collationType: .binary)
            ]))
        
        let platform = NSEntityDescription(name: "Platform")
        let platform_identifier = NSAttributeDescription(name: "identifier", type: .stringAttributeType)
        platform.properties.append(NSAttributeDescription(name: "buildNumber", type: .stringAttributeType))
        platform.properties.append(NSAttributeDescription(name: "displayName", type: .stringAttributeType))
        platform.properties.append(platform_identifier)
        platform.properties.append(NSAttributeDescription(name: "platformIdentifier", type: .stringAttributeType))
        platform.properties.append(NSAttributeDescription(name: "simulatorIdentifier", type: .stringAttributeType))
        platform.properties.append(NSAttributeDescription(name: "version", type: .stringAttributeType))
        
        platform.indexes.append(NSFetchIndexDescription(name: "byPropertyIndex", elements: [
            NSFetchIndexElementDescription(property: platform_identifier, collationType: .binary)
            ]))
        
        let repository = NSEntityDescription(name: "Repository")
        let repository_identifier = NSAttributeDescription(name: "identifier", type: .stringAttributeType, isOptional: false, defaultValue: "a935c1bc28dc4ccd9b9074346afb62bd")
        repository.properties.append(NSAttributeDescription(name: "branchIdentifier", type: .stringAttributeType))
        repository.properties.append(NSAttributeDescription(name: "branchOptions", type: .integer16AttributeType, defaultValue: 0))
        repository.properties.append(repository_identifier)
        repository.properties.append(NSAttributeDescription(name: "locationType", type: .stringAttributeType))
        repository.properties.append(NSAttributeDescription(name: "system", type: .stringAttributeType))
        repository.properties.append(NSAttributeDescription(name: "url", type: .stringAttributeType))
        repository.properties.append(NSAttributeDescription(name: "workingCopyPath", type: .stringAttributeType))
        repository.properties.append(NSAttributeDescription(name: "workingCopyState", type: .integer32AttributeType, defaultValue: 0))
        
        repository.indexes.append(NSFetchIndexDescription(name: "byPropertyIndex", elements: [
            NSFetchIndexElementDescription(property: repository_identifier, collationType: .binary)
            ]))
        
        let revisionBlueprint = NSEntityDescription(name: "RevisionBlueprint")
        
        let server = NSEntityDescription(name: "Server")
        let server_fqdn = NSAttributeDescription(name: "fqdn", type: .stringAttributeType, isOptional: false, defaultValue: "_fqdn")
        server.properties.append(NSAttributeDescription(name: "apiVersion", type: .integer32AttributeType, defaultValue: 0))
        server.properties.append(server_fqdn)
        server.properties.append(NSAttributeDescription(name: "lastUpdate", type: .dateAttributeType))
        server.properties.append(NSAttributeDescription(name: "os", type: .stringAttributeType))
        server.properties.append(NSAttributeDescription(name: "server", type: .stringAttributeType))
        server.properties.append(NSAttributeDescription(name: "xcode", type: .stringAttributeType))
        server.properties.append(NSAttributeDescription(name: "xcodeServer", type: .stringAttributeType))
        
        server.indexes.append(NSFetchIndexDescription(name: "byPropertyIndex", elements: [
            NSFetchIndexElementDescription(property: server_fqdn, collationType: .binary)
            ]))
        
        let stats = NSEntityDescription(name: "Stats")
        stats.properties.append(NSAttributeDescription(name: "codeCoveragePercentageDelta", type: .integer32AttributeType, defaultValue: 0))
        stats.properties.append(NSAttributeDescription(name: "numberOfCommits", type: .integer32AttributeType, defaultValue: 0))
        stats.properties.append(NSAttributeDescription(name: "numberOfIntegrations", type: .integer32AttributeType, defaultValue: 0))
        stats.properties.append(NSAttributeDescription(name: "numberOfSuccessfulIntegrations", type: .integer32AttributeType, defaultValue: 0))
        stats.properties.append(NSAttributeDescription(name: "sinceDate", type: .stringAttributeType))
        stats.properties.append(NSAttributeDescription(name: "testAdditionRate", type: .integer32AttributeType, defaultValue: 0))
        
        let statsBreakdown = NSEntityDescription(name: "StatsBreakdown")
        statsBreakdown.properties.append(NSAttributeDescription(name: "avg", type: .doubleAttributeType, defaultValue: 0.0))
        statsBreakdown.properties.append(NSAttributeDescription(name: "count", type: .integer32AttributeType, defaultValue: 0))
        statsBreakdown.properties.append(NSAttributeDescription(name: "max", type: .doubleAttributeType, defaultValue: 0.0))
        statsBreakdown.properties.append(NSAttributeDescription(name: "min", type: .doubleAttributeType, defaultValue: 0.0))
        statsBreakdown.properties.append(NSAttributeDescription(name: "stdDev", type: .doubleAttributeType, defaultValue: 0.0))
        statsBreakdown.properties.append(NSAttributeDescription(name: "sum", type: .doubleAttributeType, defaultValue: 0.0))
        
        let trigger = NSEntityDescription(name: "Trigger")
        trigger.properties.append(NSAttributeDescription(name: "name", type: .stringAttributeType))
        trigger.properties.append(NSAttributeDescription(name: "phaseRawValue", type: .integer16AttributeType, defaultValue: 0))
        trigger.properties.append(NSAttributeDescription(name: "scriptBody", type: .stringAttributeType))
        trigger.properties.append(NSAttributeDescription(name: "typeRawValue", type: .integer16AttributeType, defaultValue: 0))
        
        let asset_inverseArchive = NSRelationshipDescription(name: "inverseArchive", minCount: 0, maxCount: 1, deleteRule: .nullifyDeleteRule)
        let asset_inverseBuildServiceLog = NSRelationshipDescription(name: "inverseBuildServiceLog", minCount: 0, maxCount: 1, deleteRule: .nullifyDeleteRule)
        let asset_inverseProduct = NSRelationshipDescription(name: "inverseProduct", minCount: 0, maxCount: 1, deleteRule: .nullifyDeleteRule)
        let asset_inverseSourceControlLog = NSRelationshipDescription(name: "inverseSourceControlLog", minCount: 0, maxCount: 1, deleteRule: .nullifyDeleteRule)
        let asset_inverseTriggerAssets = NSRelationshipDescription(name: "inverseTriggerAssets", minCount: 0, maxCount: 1, deleteRule: .nullifyDeleteRule)
        let asset_inverseXcodebuildLog = NSRelationshipDescription(name: "inverseXcodebuildLog", minCount: 0, maxCount: 1, deleteRule: .nullifyDeleteRule)
        let asset_inverseXcodebuildOutput = NSRelationshipDescription(name: "inverseXcodebuildOutput", minCount: 0, maxCount: 1, deleteRule: .nullifyDeleteRule)
        let bot_configuration = NSRelationshipDescription(name: "configuration", minCount: 0, maxCount: 1, deleteRule: .cascadeDeleteRule)
        let bot_integrations = NSRelationshipDescription(name: "integrations", minCount: 0, maxCount: 0, deleteRule: .cascadeDeleteRule)
        let bot_stats = NSRelationshipDescription(name: "stats", minCount: 0, maxCount: 1, deleteRule: .cascadeDeleteRule)
        let bot_server = NSRelationshipDescription(name: "server", minCount: 0, maxCount: 1, deleteRule: .nullifyDeleteRule)
        let buildResultSummary_integration = NSRelationshipDescription(name: "integration", minCount: 0, maxCount: 1, deleteRule: .nullifyDeleteRule)
        let commit_commitChanges = NSRelationshipDescription(name: "commitChanges", minCount: 0, maxCount: 0, deleteRule: .cascadeDeleteRule)
        let commit_commitContributor = NSRelationshipDescription(name: "commitContributor", minCount: 0, maxCount: 1, deleteRule: .cascadeDeleteRule)
        let commit_repository = NSRelationshipDescription(name: "repository", minCount: 0, maxCount: 1, deleteRule: .nullifyDeleteRule)
        let commit_revisionBlueprints = NSRelationshipDescription(name: "revisionBlueprints", minCount: 0, maxCount: 0, deleteRule: .nullifyDeleteRule)
        let commitChange_commit = NSRelationshipDescription(name: "commit", maxCount: 1, deleteRule: .nullifyDeleteRule)
        let commitContributor_commit = NSRelationshipDescription(name: "commit", maxCount: 1, deleteRule: .nullifyDeleteRule)
        let conditions_trigger = NSRelationshipDescription(name: "trigger", maxCount: 1, deleteRule: .cascadeDeleteRule)
        let configuration_bot = NSRelationshipDescription(name: "bot", maxCount: 1, deleteRule: .nullifyDeleteRule)
        let configuration_deviceSpecification = NSRelationshipDescription(name: "deviceSpecification", maxCount: 1, deleteRule: .cascadeDeleteRule)
        let configuration_repositories = NSRelationshipDescription(name: "repositories", maxCount: 0, deleteRule: .nullifyDeleteRule)
        let configuration_triggers = NSRelationshipDescription(name: "triggers", maxCount: 0, deleteRule: .cascadeDeleteRule)
        let device_activeProxiedDevice = NSRelationshipDescription(name: "activeProxiedDevice", maxCount: 1, deleteRule: .nullifyDeleteRule)
        let device_deviceSpecifications = NSRelationshipDescription(name: "deviceSpecifications", maxCount: 0, deleteRule: .nullifyDeleteRule)
        let device_integrations = NSRelationshipDescription(name: "integrations", maxCount: 0, deleteRule: .nullifyDeleteRule)
        let device_inverseActiveProxiedDevice = NSRelationshipDescription(name: "inverseActiveProxiedDevice", maxCount: 1, deleteRule: .nullifyDeleteRule)
        let deviceSpecification_configuration = NSRelationshipDescription(name: "configuration", maxCount: 1, deleteRule: .nullifyDeleteRule)
        let deviceSpecification_devices = NSRelationshipDescription(name: "devices", maxCount: 0, deleteRule: .nullifyDeleteRule)
        let deviceSpecification_filters = NSRelationshipDescription(name: "filters", maxCount: 0, deleteRule: .cascadeDeleteRule)
        let emailConfiguration_trigger = NSRelationshipDescription(name: "trigger", maxCount: 1, deleteRule: .nullifyDeleteRule)
        let filter_deviceSpecification = NSRelationshipDescription(name: "deviceSpecification", maxCount: 1, deleteRule: .nullifyDeleteRule)
        let filter_platform = NSRelationshipDescription(name: "platform", maxCount: 1, deleteRule: .cascadeDeleteRule)
        let integration_assets = NSRelationshipDescription(name: "assets", maxCount: 1, deleteRule: .cascadeDeleteRule)
        let integration_bot = NSRelationshipDescription(name: "bot", maxCount: 1, deleteRule: .nullifyDeleteRule)
        let integration_buildResultSummary = NSRelationshipDescription(name: "buildResultSummary", maxCount: 1, deleteRule: .cascadeDeleteRule)
        let integration_inverseBestSuccessStreak = NSRelationshipDescription(name: "inverseBestSuccessStreak", maxCount: 1, deleteRule: .nullifyDeleteRule)
        let integration_inverseLastCleanIntegration = NSRelationshipDescription(name: "inverseLastCleanIntegration", maxCount: 1, deleteRule: .nullifyDeleteRule)
        let integration_issues = NSRelationshipDescription(name: "issues", maxCount: 1, deleteRule: .cascadeDeleteRule)
        let integration_revisionBlueprints = NSRelationshipDescription(name: "revisionBlueprints", maxCount: 0, deleteRule: .cascadeDeleteRule)
        let integration_testedDevices = NSRelationshipDescription(name: "testedDevices", maxCount: 0, deleteRule: .nullifyDeleteRule)
        let integrationAssets_archive = NSRelationshipDescription(name: "archive", maxCount: 1, deleteRule: .cascadeDeleteRule)
        let integrationAssets_buildServiceLog = NSRelationshipDescription(name: "buildServiceLog", maxCount: 1, deleteRule: .cascadeDeleteRule)
        let integrationAssets_integration = NSRelationshipDescription(name: "integration", maxCount: 1, deleteRule: .nullifyDeleteRule)
        let integrationAssets_product = NSRelationshipDescription(name: "product", maxCount: 1, deleteRule: .cascadeDeleteRule)
        let integrationAssets_sourceControlLog = NSRelationshipDescription(name: "sourceControlLog", maxCount: 1, deleteRule: .cascadeDeleteRule)
        let integrationAssets_triggerAssets = NSRelationshipDescription(name: "triggerAssets", maxCount: 0, deleteRule: .cascadeDeleteRule)
        let integrationAssets_xcodebuildLog = NSRelationshipDescription(name: "xcodebuildLog", maxCount: 1, deleteRule: .cascadeDeleteRule)
        let integrationAssets_xcodebuildOutput = NSRelationshipDescription(name: "xcodebuildOutput", maxCount: 1, deleteRule: .cascadeDeleteRule)
        let integrationIssues_buildServiceErrors = NSRelationshipDescription(name: "buildServiceErrors", maxCount: 0, deleteRule: .cascadeDeleteRule)
        let integrationIssues_buildServiceWarnings = NSRelationshipDescription(name: "buildServiceWarnings", maxCount: 0, deleteRule: .cascadeDeleteRule)
        let integrationIssues_freshAnalyzerWarnings = NSRelationshipDescription(name: "freshAnalyzerWarnings", maxCount: 0, deleteRule: .cascadeDeleteRule)
        let integrationIssues_freshErrors = NSRelationshipDescription(name: "freshErrors", maxCount: 0, deleteRule: .cascadeDeleteRule)
        let integrationIssues_freshTestFailures = NSRelationshipDescription(name: "freshTestFailures", maxCount: 0, deleteRule: .cascadeDeleteRule)
        let integrationIssues_freshWarnings = NSRelationshipDescription(name: "freshWarnings", maxCount: 0, deleteRule: .cascadeDeleteRule)
        let integrationIssues_integration = NSRelationshipDescription(name: "integration", maxCount: 1, deleteRule: .nullifyDeleteRule)
        let integrationIssues_resolvedAnalyzerWarnings = NSRelationshipDescription(name: "resolvedAnalyzerWarnings", maxCount: 0, deleteRule: .cascadeDeleteRule)
        let integrationIssues_resolvedErrors = NSRelationshipDescription(name: "resolvedErrors", maxCount: 0, deleteRule: .cascadeDeleteRule)
        let integrationIssues_resolvedTestFailures = NSRelationshipDescription(name: "resolvedTestFailures", maxCount: 0, deleteRule: .cascadeDeleteRule)
        let integrationIssues_resolvedWarnings = NSRelationshipDescription(name: "resolvedWarnings", maxCount: 0, deleteRule: .cascadeDeleteRule)
        let integrationIssues_unresolvedAnalyzerWarnings = NSRelationshipDescription(name: "unresolvedAnalyzerWarnings", maxCount: 0, deleteRule: .cascadeDeleteRule)
        let integrationIssues_unresolvedErrors = NSRelationshipDescription(name: "unresolvedErrors", maxCount: 0, deleteRule: .cascadeDeleteRule)
        let integrationIssues_unresolvedTestFailures = NSRelationshipDescription(name: "unresolvedTestFailures", maxCount: 0, deleteRule: .cascadeDeleteRule)
        let integrationIssues_unresolvedWarnings = NSRelationshipDescription(name: "unresolvedWarnings", maxCount: 0, deleteRule: .cascadeDeleteRule)
        let integrationIssues_triggerErrors = NSRelationshipDescription(name: "triggerErrors", maxCount: 0, deleteRule: .cascadeDeleteRule)
        let issue_inverseBuildServiceErrors = NSRelationshipDescription(name: "inverseBuildServiceErrors", maxCount: 1, deleteRule: .nullifyDeleteRule)
        let issue_inverseBuildServiceWarnings = NSRelationshipDescription(name: "inverseBuildServiceWarnings", maxCount: 1, deleteRule: .nullifyDeleteRule)
        let issue_inverseFreshAnalyzerWarnings = NSRelationshipDescription(name: "inverseFreshAnalyzerWarnings", maxCount: 1, deleteRule: .nullifyDeleteRule)
        let issue_inverseFreshErrors = NSRelationshipDescription(name: "inverseFreshErrors", maxCount: 1, deleteRule: .nullifyDeleteRule)
        let issue_inverseFreshTestFailures = NSRelationshipDescription(name: "inverseFreshTestFailures", maxCount: 1, deleteRule: .nullifyDeleteRule)
        let issue_inverseFreshWarnings = NSRelationshipDescription(name: "inverseFreshWarnings", maxCount: 1, deleteRule: .nullifyDeleteRule)
        let issue_inverseResolvedAnalyzerWarnings = NSRelationshipDescription(name: "inverseResolvedAnalyzerWarnings", maxCount: 1, deleteRule: .nullifyDeleteRule)
        let issue_inverseResolvedErrors = NSRelationshipDescription(name: "inverseResolvedErrors", maxCount: 1, deleteRule: .nullifyDeleteRule)
        let issue_inverseResolvedTestFailures = NSRelationshipDescription(name: "inverseResolvedTestFailures", maxCount: 1, deleteRule: .nullifyDeleteRule)
        let issue_inverseResolvedWarnings = NSRelationshipDescription(name: "inverseResolvedWarnings", maxCount: 1, deleteRule: .nullifyDeleteRule)
        let issue_inverseUnresolvedAnalyzerWarnings = NSRelationshipDescription(name: "inverseUnresolvedAnalyzerWarnings", maxCount: 1, deleteRule: .nullifyDeleteRule)
        let issue_inverseUnresolvedErrors = NSRelationshipDescription(name: "inverseUnresolvedErrors", maxCount: 1, deleteRule: .nullifyDeleteRule)
        let issue_inverseUnresolvedTestFailures = NSRelationshipDescription(name: "inverseUnresolvedTestFailures", maxCount: 1, deleteRule: .nullifyDeleteRule)
        let issue_inverseUnresolvedWarnings = NSRelationshipDescription(name: "inverseUnresolvedWarnings", maxCount: 1, deleteRule: .nullifyDeleteRule)
        let issue_inverseTriggerErrors = NSRelationshipDescription(name: "inverseTriggerErrors", maxCount: 1, deleteRule: .nullifyDeleteRule)
        let platform_filter = NSRelationshipDescription(name: "filter", maxCount: 1, deleteRule: .nullifyDeleteRule)
        let repository_commits = NSRelationshipDescription(name: "commits", maxCount: 0, deleteRule: .cascadeDeleteRule)
        let repository_configurations = NSRelationshipDescription(name: "configurations", maxCount: 0, deleteRule: .nullifyDeleteRule)
        let revisionBlueprint_commit = NSRelationshipDescription(name: "commit", maxCount: 1, deleteRule: .nullifyDeleteRule)
        let revisionBlueprint_integration = NSRelationshipDescription(name: "integration", maxCount: 1, deleteRule: .nullifyDeleteRule)
        let server_bots = NSRelationshipDescription(name: "bots", maxCount: 0, deleteRule: .cascadeDeleteRule)
        let stats_analysisWarnings = NSRelationshipDescription(name: "analysisWarnings", maxCount: 1, deleteRule: .cascadeDeleteRule)
        let stats_averageIntegrationTime = NSRelationshipDescription(name: "averageIntegrationTime", maxCount: 1, deleteRule: .cascadeDeleteRule)
        let stats_bestSuccessStreak = NSRelationshipDescription(name: "bestSuccessStreak", maxCount: 1, deleteRule: .nullifyDeleteRule)
        let stats_bot = NSRelationshipDescription(name: "bot", maxCount: 1, deleteRule: .nullifyDeleteRule)
        let stats_errors = NSRelationshipDescription(name: "errors", maxCount: 1, deleteRule: .cascadeDeleteRule)
        let stats_improvedPerfTests = NSRelationshipDescription(name: "improvedPerfTests", maxCount: 1, deleteRule: .cascadeDeleteRule)
        let stats_lastCleanIntegration = NSRelationshipDescription(name: "lastCleanIntegration", maxCount: 1, deleteRule: .nullifyDeleteRule)
        let stats_regressedPerfTests = NSRelationshipDescription(name: "regressedPerfTests", maxCount: 1, deleteRule: .cascadeDeleteRule)
        let stats_testFailures = NSRelationshipDescription(name: "testFailures", maxCount: 1, deleteRule: .cascadeDeleteRule)
        let stats_tests = NSRelationshipDescription(name: "tests", maxCount: 1, deleteRule: .cascadeDeleteRule)
        let stats_warnings = NSRelationshipDescription(name: "warnings", maxCount: 1, deleteRule: .cascadeDeleteRule)
        let statsBreakdown_inverseAnalysisWarnings = NSRelationshipDescription(name: "inverseAnalysisWarnings", maxCount: 1, deleteRule: .nullifyDeleteRule)
        let statsBreakdown_inverseAverageIntegrationTime = NSRelationshipDescription(name: "inverseAverageIntegrationTime", maxCount: 1, deleteRule: .nullifyDeleteRule)
        let statsBreakdown_inverseErrors = NSRelationshipDescription(name: "inverseErrors", maxCount: 1, deleteRule: .nullifyDeleteRule)
        let statsBreakdown_inverseImprovedPerfTests = NSRelationshipDescription(name: "inverseImprovedPerfTests", maxCount: 1, deleteRule: .nullifyDeleteRule)
        let statsBreakdown_inverseRegressedPerfTests = NSRelationshipDescription(name: "inverseRegressedPerfTests", maxCount: 1, deleteRule: .nullifyDeleteRule)
        let statsBreakdown_inverseTestFailures = NSRelationshipDescription(name: "inverseTestFailures", maxCount: 1, deleteRule: .nullifyDeleteRule)
        let statsBreakdown_inverseTests = NSRelationshipDescription(name: "inverseTests", maxCount: 1, deleteRule: .nullifyDeleteRule)
        let statsBreakdown_inverseWarnings = NSRelationshipDescription(name: "inverseWarnings", maxCount: 1, deleteRule: .nullifyDeleteRule)
        let trigger_conditions = NSRelationshipDescription(name: "conditions", maxCount: 1, deleteRule: .cascadeDeleteRule)
        let trigger_configuration = NSRelationshipDescription(name: "configuration", maxCount: 1, deleteRule: .nullifyDeleteRule)
        let trigger_emailConfiguration = NSRelationshipDescription(name: "emailConfiguration", maxCount: 1, deleteRule: .cascadeDeleteRule)
        
        asset_inverseArchive.destinationEntity = integrationAssets
        asset_inverseArchive.inverseRelationship = integrationAssets_archive
        asset_inverseBuildServiceLog.destinationEntity = integrationAssets
        asset_inverseBuildServiceLog.inverseRelationship = integrationAssets_buildServiceLog
        asset_inverseProduct.destinationEntity = integrationAssets
        asset_inverseProduct.inverseRelationship = integrationAssets_product
        asset_inverseSourceControlLog.destinationEntity = integrationAssets
        asset_inverseSourceControlLog.inverseRelationship = integrationAssets_sourceControlLog
        asset_inverseTriggerAssets.destinationEntity = integrationAssets
        asset_inverseTriggerAssets.inverseRelationship = integrationAssets_triggerAssets
        asset_inverseXcodebuildLog.destinationEntity = integrationAssets
        asset_inverseXcodebuildLog.inverseRelationship = integrationAssets_xcodebuildLog
        asset_inverseXcodebuildOutput.destinationEntity = integrationAssets
        asset_inverseXcodebuildOutput.inverseRelationship = integrationAssets_xcodebuildOutput
        
        bot_configuration.destinationEntity = configuration
        bot_configuration.inverseRelationship = configuration_bot
        bot_integrations.destinationEntity = integration
        bot_integrations.inverseRelationship = integration_bot
        bot_stats.destinationEntity = stats
        bot_stats.inverseRelationship = stats_bot
        bot_server.destinationEntity = server
        bot_server.inverseRelationship = server_bots
        
        buildResultSummary_integration.destinationEntity = integration
        buildResultSummary_integration.inverseRelationship = integration_buildResultSummary
        
        commit_commitChanges.destinationEntity = commitChange
        commit_commitChanges.inverseRelationship = commitChange_commit
        commit_commitContributor.destinationEntity = commitContributor
        commit_commitContributor.inverseRelationship = commitContributor_commit
        commit_repository.destinationEntity = repository
        commit_repository.inverseRelationship = repository_commits
        commit_revisionBlueprints.destinationEntity = revisionBlueprint
        commit_revisionBlueprints.inverseRelationship = revisionBlueprint_commit
        
        commitChange_commit.destinationEntity = commit
        commitChange_commit.inverseRelationship = commit_commitChanges
        
        commitContributor_commit.destinationEntity = commit
        commitContributor_commit.inverseRelationship = commit_commitContributor
        
        conditions_trigger.destinationEntity = trigger
        conditions_trigger.inverseRelationship = trigger_conditions
        
        configuration_bot.destinationEntity = bot
        configuration_bot.inverseRelationship = bot_configuration
        configuration_deviceSpecification.destinationEntity = deviceSpecification
        configuration_deviceSpecification.inverseRelationship = deviceSpecification_configuration
        configuration_repositories.destinationEntity = repository
        configuration_repositories.inverseRelationship = repository_configurations
        configuration_triggers.destinationEntity = trigger
        configuration_triggers.inverseRelationship = trigger_configuration
        
        device_activeProxiedDevice.destinationEntity = device
        device_activeProxiedDevice.inverseRelationship = device_inverseActiveProxiedDevice
        device_deviceSpecifications.destinationEntity = deviceSpecification
        device_deviceSpecifications.inverseRelationship = deviceSpecification_devices
        device_integrations.destinationEntity = integration
        device_integrations.inverseRelationship = integration_testedDevices
        device_inverseActiveProxiedDevice.destinationEntity = device
        device_inverseActiveProxiedDevice.inverseRelationship = device_activeProxiedDevice
        
        deviceSpecification_configuration.destinationEntity = configuration
        deviceSpecification_configuration.inverseRelationship = configuration_deviceSpecification
        deviceSpecification_devices.destinationEntity = device
        deviceSpecification_devices.inverseRelationship  = device_deviceSpecifications
        deviceSpecification_filters.destinationEntity = filter
        deviceSpecification_filters.inverseRelationship = filter_deviceSpecification
        
        emailConfiguration_trigger.destinationEntity = trigger
        emailConfiguration_trigger.inverseRelationship = trigger_emailConfiguration
        
        filter_deviceSpecification.destinationEntity = deviceSpecification
        filter_deviceSpecification.inverseRelationship = deviceSpecification_filters
        filter_platform.destinationEntity = platform
        filter_platform.inverseRelationship = platform_filter
        
        integration_assets.destinationEntity = integrationAssets
        integration_assets.inverseRelationship = integrationAssets_integration
        integration_bot.destinationEntity = bot
        integration_bot.inverseRelationship = bot_integrations
        integration_buildResultSummary.destinationEntity = buildResultSummary
        integration_buildResultSummary.inverseRelationship = buildResultSummary_integration
        integration_inverseBestSuccessStreak.destinationEntity = stats
        integration_inverseBestSuccessStreak.inverseRelationship = stats_bestSuccessStreak
        integration_inverseLastCleanIntegration.destinationEntity = stats
        integration_inverseLastCleanIntegration.inverseRelationship = stats_lastCleanIntegration
        integration_issues.destinationEntity = integrationIssues
        integration_issues.inverseRelationship = integrationIssues_integration
        integration_revisionBlueprints.destinationEntity = revisionBlueprint
        integration_revisionBlueprints.inverseRelationship = revisionBlueprint_integration
        integration_testedDevices.destinationEntity = device
        integration_testedDevices.inverseRelationship = device_integrations
        
        integrationAssets_archive.destinationEntity = asset
        integrationAssets_archive.inverseRelationship = asset_inverseArchive
        integrationAssets_buildServiceLog.destinationEntity = asset
        integrationAssets_buildServiceLog.inverseRelationship = asset_inverseBuildServiceLog
        integrationAssets_integration.destinationEntity = integration
        integrationAssets_integration.inverseRelationship = integration_assets
        integrationAssets_product.destinationEntity = asset
        integrationAssets_product.inverseRelationship = asset_inverseProduct
        integrationAssets_sourceControlLog.destinationEntity = asset
        integrationAssets_sourceControlLog.inverseRelationship = asset_inverseSourceControlLog
        integrationAssets_triggerAssets.destinationEntity = asset
        integrationAssets_triggerAssets.inverseRelationship = asset_inverseTriggerAssets
        integrationAssets_xcodebuildLog.destinationEntity = asset
        integrationAssets_xcodebuildLog.inverseRelationship = asset_inverseXcodebuildLog
        integrationAssets_xcodebuildOutput.destinationEntity = asset
        integrationAssets_xcodebuildOutput.inverseRelationship = asset_inverseXcodebuildOutput
        
        integrationIssues_buildServiceErrors.destinationEntity = issue
        integrationIssues_buildServiceErrors.inverseRelationship = issue_inverseBuildServiceErrors
        integrationIssues_buildServiceWarnings.destinationEntity = issue
        integrationIssues_buildServiceWarnings.inverseRelationship = issue_inverseBuildServiceWarnings
        integrationIssues_freshAnalyzerWarnings.destinationEntity = issue
        integrationIssues_freshAnalyzerWarnings.inverseRelationship = issue_inverseFreshAnalyzerWarnings
        integrationIssues_freshErrors.destinationEntity = issue
        integrationIssues_freshErrors.inverseRelationship = issue_inverseFreshErrors
        integrationIssues_freshTestFailures.destinationEntity = issue
        integrationIssues_freshTestFailures.inverseRelationship = issue_inverseFreshTestFailures
        integrationIssues_freshWarnings.destinationEntity = issue
        integrationIssues_freshWarnings.inverseRelationship = issue_inverseFreshWarnings
        integrationIssues_integration.destinationEntity = integration
        integrationIssues_integration.inverseRelationship = integration_issues
        integrationIssues_resolvedAnalyzerWarnings.destinationEntity = issue
        integrationIssues_resolvedAnalyzerWarnings.inverseRelationship = issue_inverseResolvedAnalyzerWarnings
        integrationIssues_resolvedErrors.destinationEntity = issue
        integrationIssues_resolvedErrors.inverseRelationship = issue_inverseResolvedErrors
        integrationIssues_resolvedTestFailures.destinationEntity = issue
        integrationIssues_resolvedTestFailures.inverseRelationship = issue_inverseResolvedTestFailures
        integrationIssues_resolvedWarnings.destinationEntity = issue
        integrationIssues_resolvedWarnings.inverseRelationship = issue_inverseResolvedWarnings
        integrationIssues_unresolvedAnalyzerWarnings.destinationEntity = issue
        integrationIssues_unresolvedAnalyzerWarnings.inverseRelationship = issue_inverseUnresolvedAnalyzerWarnings
        integrationIssues_unresolvedErrors.destinationEntity = issue
        integrationIssues_unresolvedErrors.inverseRelationship = issue_inverseUnresolvedErrors
        integrationIssues_unresolvedTestFailures.destinationEntity = issue
        integrationIssues_unresolvedTestFailures.inverseRelationship = issue_inverseUnresolvedTestFailures
        integrationIssues_unresolvedWarnings.destinationEntity = issue
        integrationIssues_unresolvedWarnings.inverseRelationship = issue_inverseUnresolvedWarnings
        integrationIssues_triggerErrors.destinationEntity = issue
        integrationIssues_triggerErrors.inverseRelationship = issue_inverseTriggerErrors
        
        issue_inverseBuildServiceErrors.destinationEntity = integrationIssues
        issue_inverseBuildServiceErrors.inverseRelationship = integrationIssues_buildServiceErrors
        issue_inverseBuildServiceWarnings.destinationEntity = integrationIssues
        issue_inverseBuildServiceWarnings.inverseRelationship = integrationIssues_buildServiceWarnings
        issue_inverseFreshAnalyzerWarnings.destinationEntity = integrationIssues
        issue_inverseFreshAnalyzerWarnings.inverseRelationship = integrationIssues_freshAnalyzerWarnings
        issue_inverseFreshErrors.destinationEntity = integrationIssues
        issue_inverseFreshErrors.inverseRelationship = integrationIssues_freshErrors
        issue_inverseFreshTestFailures.destinationEntity = integrationIssues
        issue_inverseFreshTestFailures.inverseRelationship = integrationIssues_freshTestFailures
        issue_inverseFreshWarnings.destinationEntity = integrationIssues
        issue_inverseFreshWarnings.inverseRelationship = integrationIssues_freshWarnings
        issue_inverseResolvedAnalyzerWarnings.destinationEntity = integrationIssues
        issue_inverseResolvedAnalyzerWarnings.inverseRelationship = integrationIssues_resolvedAnalyzerWarnings
        issue_inverseResolvedErrors.destinationEntity = integrationIssues
        issue_inverseResolvedErrors.inverseRelationship = integrationIssues_resolvedErrors
        issue_inverseResolvedTestFailures.destinationEntity = integrationIssues
        issue_inverseResolvedTestFailures.inverseRelationship = integrationIssues_resolvedTestFailures
        issue_inverseResolvedWarnings.destinationEntity = integrationIssues
        issue_inverseResolvedWarnings.inverseRelationship = integrationIssues_resolvedWarnings
        issue_inverseUnresolvedAnalyzerWarnings.destinationEntity = integrationIssues
        issue_inverseUnresolvedAnalyzerWarnings.inverseRelationship = integrationIssues_unresolvedAnalyzerWarnings
        issue_inverseUnresolvedErrors.destinationEntity = integrationIssues
        issue_inverseUnresolvedErrors.inverseRelationship = integrationIssues_unresolvedErrors
        issue_inverseUnresolvedTestFailures.destinationEntity = integrationIssues
        issue_inverseUnresolvedTestFailures.inverseRelationship = integrationIssues_unresolvedTestFailures
        issue_inverseUnresolvedWarnings.destinationEntity = integrationIssues
        issue_inverseUnresolvedWarnings.inverseRelationship = integrationIssues_unresolvedWarnings
        issue_inverseTriggerErrors.destinationEntity = integrationIssues
        issue_inverseTriggerErrors.inverseRelationship = integrationIssues_triggerErrors
        
        platform_filter.destinationEntity = filter
        platform_filter.inverseRelationship = filter_platform
        
        repository_commits.destinationEntity = commit
        repository_commits.inverseRelationship = commit_repository
        repository_configurations.destinationEntity = configuration
        repository_configurations.inverseRelationship = configuration_repositories
        
        revisionBlueprint_commit.destinationEntity = commit
        revisionBlueprint_commit.inverseRelationship = commit_revisionBlueprints
        revisionBlueprint_integration.destinationEntity = integration
        revisionBlueprint_integration.inverseRelationship = integration_revisionBlueprints
        
        server_bots.destinationEntity = bot
        server_bots.inverseRelationship = bot_server
        
        stats_analysisWarnings.destinationEntity = statsBreakdown
        stats_analysisWarnings.inverseRelationship = statsBreakdown_inverseAnalysisWarnings
        stats_averageIntegrationTime.destinationEntity = statsBreakdown
        stats_averageIntegrationTime.inverseRelationship = statsBreakdown_inverseAverageIntegrationTime
        stats_bestSuccessStreak.destinationEntity = integration
        stats_bestSuccessStreak.inverseRelationship = integration_inverseBestSuccessStreak
        stats_bot.destinationEntity = bot
        stats_bot.inverseRelationship = bot_stats
        stats_errors.destinationEntity = statsBreakdown
        stats_errors.inverseRelationship = statsBreakdown_inverseErrors
        stats_improvedPerfTests.destinationEntity = statsBreakdown
        stats_improvedPerfTests.inverseRelationship = statsBreakdown_inverseImprovedPerfTests
        stats_lastCleanIntegration.destinationEntity = integration
        stats_lastCleanIntegration.inverseRelationship = integration_inverseLastCleanIntegration
        stats_regressedPerfTests.destinationEntity = statsBreakdown
        stats_regressedPerfTests.inverseRelationship = statsBreakdown_inverseRegressedPerfTests
        stats_testFailures.destinationEntity = statsBreakdown
        stats_testFailures.inverseRelationship = statsBreakdown_inverseTestFailures
        stats_tests.destinationEntity = statsBreakdown
        stats_tests.inverseRelationship = statsBreakdown_inverseTests
        stats_warnings.destinationEntity = statsBreakdown
        stats_warnings.inverseRelationship = statsBreakdown_inverseWarnings
        
        statsBreakdown_inverseAnalysisWarnings.destinationEntity = stats
        statsBreakdown_inverseAnalysisWarnings.inverseRelationship = stats_analysisWarnings
        statsBreakdown_inverseAverageIntegrationTime.destinationEntity = stats
        statsBreakdown_inverseAverageIntegrationTime.inverseRelationship = stats_averageIntegrationTime
        statsBreakdown_inverseErrors.destinationEntity = stats
        statsBreakdown_inverseErrors.inverseRelationship = stats_errors
        statsBreakdown_inverseImprovedPerfTests.destinationEntity = stats
        statsBreakdown_inverseImprovedPerfTests.inverseRelationship = stats_improvedPerfTests
        statsBreakdown_inverseRegressedPerfTests.destinationEntity = stats
        statsBreakdown_inverseRegressedPerfTests.inverseRelationship = stats_regressedPerfTests
        statsBreakdown_inverseTestFailures.destinationEntity = stats
        statsBreakdown_inverseTestFailures.inverseRelationship = stats_testFailures
        statsBreakdown_inverseTests.destinationEntity = stats
        statsBreakdown_inverseTests.inverseRelationship = stats_tests
        statsBreakdown_inverseWarnings.destinationEntity = stats
        statsBreakdown_inverseWarnings.inverseRelationship = stats_warnings
        
        trigger_conditions.destinationEntity = conditions
        trigger_conditions.inverseRelationship = conditions_trigger
        trigger_configuration.destinationEntity = configuration
        trigger_configuration.inverseRelationship = configuration_triggers
        trigger_emailConfiguration.destinationEntity = emailConfiguration
        trigger_emailConfiguration.inverseRelationship = emailConfiguration_trigger
        
        asset.properties.append(contentsOf: [
            asset_inverseArchive,
            asset_inverseBuildServiceLog,
            asset_inverseProduct,
            asset_inverseSourceControlLog,
            asset_inverseTriggerAssets,
            asset_inverseXcodebuildLog,
            asset_inverseXcodebuildOutput,
            ])
        
        bot.properties.append(contentsOf: [
            bot_configuration,
            bot_integrations,
            bot_stats,
            bot_server,
            ])
        
        buildResultSummary.properties.append(contentsOf: [
            buildResultSummary_integration,
            ])
        
        commit.properties.append(contentsOf: [
            commit_commitChanges,
            commit_commitContributor,
            commit_repository,
            commit_revisionBlueprints,
            ])
        
        commitChange.properties.append(contentsOf: [
            commitChange_commit,
            ])
        
        commitContributor.properties.append(contentsOf: [
            commitContributor_commit,
            ])
        
        conditions.properties.append(contentsOf: [
            conditions_trigger,
            ])
        
        configuration.properties.append(contentsOf: [
            configuration_bot,
            configuration_deviceSpecification,
            configuration_repositories,
            configuration_triggers,
            ])
        
        device.properties.append(contentsOf: [
            device_activeProxiedDevice,
            device_deviceSpecifications,
            device_integrations,
            device_inverseActiveProxiedDevice,
            ])
        
        deviceSpecification.properties.append(contentsOf: [
            deviceSpecification_configuration,
            deviceSpecification_devices,
            deviceSpecification_filters,
            ])
        
        emailConfiguration.properties.append(contentsOf: [
            emailConfiguration_trigger,
            ])
        
        filter.properties.append(contentsOf: [
            filter_deviceSpecification,
            filter_platform,
            ])
        
        integration.properties.append(contentsOf: [
            integration_assets,
            integration_bot,
            integration_buildResultSummary,
            integration_inverseBestSuccessStreak,
            integration_inverseLastCleanIntegration,
            integration_issues,
            integration_revisionBlueprints,
            integration_testedDevices,
            ])
        
        integrationAssets.properties.append(contentsOf: [
            integrationAssets_archive,
            integrationAssets_buildServiceLog,
            integrationAssets_integration,
            integrationAssets_product,
            integrationAssets_sourceControlLog,
            integrationAssets_triggerAssets,
            integrationAssets_xcodebuildLog,
            integrationAssets_xcodebuildOutput,
            ])
        
        integrationIssues.properties.append(contentsOf: [
            integrationIssues_buildServiceErrors,
            integrationIssues_buildServiceWarnings,
            integrationIssues_freshAnalyzerWarnings,
            integrationIssues_freshErrors,
            integrationIssues_freshTestFailures,
            integrationIssues_freshWarnings,
            integrationIssues_integration,
            integrationIssues_resolvedAnalyzerWarnings,
            integrationIssues_resolvedErrors,
            integrationIssues_resolvedTestFailures,
            integrationIssues_resolvedWarnings,
            integrationIssues_unresolvedAnalyzerWarnings,
            integrationIssues_unresolvedErrors,
            integrationIssues_unresolvedTestFailures,
            integrationIssues_unresolvedWarnings,
            integrationIssues_triggerErrors,
            ])
        
        issue.properties.append(contentsOf: [
            issue_inverseBuildServiceErrors,
            issue_inverseBuildServiceWarnings,
            issue_inverseFreshAnalyzerWarnings,
            issue_inverseFreshErrors,
            issue_inverseFreshTestFailures,
            issue_inverseFreshWarnings,
            issue_inverseResolvedAnalyzerWarnings,
            issue_inverseResolvedErrors,
            issue_inverseResolvedTestFailures,
            issue_inverseResolvedWarnings,
            issue_inverseUnresolvedAnalyzerWarnings,
            issue_inverseUnresolvedErrors,
            issue_inverseUnresolvedTestFailures,
            issue_inverseUnresolvedWarnings,
            issue_inverseTriggerErrors,
            ])
        
        platform.properties.append(contentsOf: [
            platform_filter,
            ])
        
        repository.properties.append(contentsOf: [
            repository_commits,
            repository_configurations,
            ])
        
        revisionBlueprint.properties.append(contentsOf: [
            revisionBlueprint_commit,
            revisionBlueprint_integration,
            ])
        
        server.properties.append(contentsOf: [
            server_bots,
            ])
        
        stats.properties.append(contentsOf: [
            stats_analysisWarnings,
            stats_averageIntegrationTime,
            stats_bestSuccessStreak,
            stats_bot,
            stats_errors,
            stats_improvedPerfTests,
            stats_lastCleanIntegration,
            stats_regressedPerfTests,
            stats_testFailures,
            stats_tests,
            stats_warnings,
            ])
        
        statsBreakdown.properties.append(contentsOf: [
            statsBreakdown_inverseAnalysisWarnings,
            statsBreakdown_inverseAverageIntegrationTime,
            statsBreakdown_inverseErrors,
            statsBreakdown_inverseImprovedPerfTests,
            statsBreakdown_inverseRegressedPerfTests,
            statsBreakdown_inverseTestFailures,
            statsBreakdown_inverseTests,
            statsBreakdown_inverseWarnings,
            ])
        
        trigger.properties.append(contentsOf: [
            trigger_conditions,
            trigger_configuration,
            trigger_emailConfiguration,
            ])
        
        entities = [
            asset, bot, buildResultSummary, commit, commitChange, commitContributor,
            conditions, configuration, device, deviceSpecification, emailConfiguration,
            filter, integration, integrationAssets, integrationIssues, issue, platform,
            repository, revisionBlueprint, server, stats, statsBreakdown, trigger,
        ]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
#endif
