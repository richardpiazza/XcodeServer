import Foundation
import CoreData

class Mapping_2_0_3_to_2_0_4: NSMappingModel {
    
    public static var instance: Mapping_2_0_3_to_2_0_4 = Mapping_2_0_3_to_2_0_4()
    
    private let sourceModel: NSManagedObjectModel = Model_2_0_3.instance
    private let destinationModel: NSManagedObjectModel = Model_2_0_4.instance
    
    private override init() {
        super.init()
        
        let asset_asset = NSEntityMapping(entityName: "Asset", sourceModel: sourceModel, destinationModel: destinationModel)
        asset_asset.attributeMappings?.append(NSPropertyMapping(name: "allowAnonymousAccess"))
        asset_asset.attributeMappings?.append(NSPropertyMapping(name: "fileName"))
        asset_asset.attributeMappings?.append(NSPropertyMapping(name: "isDirectory"))
        asset_asset.attributeMappings?.append(NSPropertyMapping(name: "relativePath"))
        asset_asset.attributeMappings?.append(NSPropertyMapping(name: "size"))
        asset_asset.attributeMappings?.append(NSPropertyMapping(name: "triggerName"))
        asset_asset.relationshipMappings?.append(NSPropertyMapping(name: "inverseArchive", entityMapping: "IntegrationAssets"))
        asset_asset.relationshipMappings?.append(NSPropertyMapping(name: "inverseBuildServiceLog", entityMapping: "IntegrationAssets"))
        asset_asset.relationshipMappings?.append(NSPropertyMapping(name: "inverseProduct", entityMapping: "IntegrationAssets"))
        asset_asset.relationshipMappings?.append(NSPropertyMapping(name: "inverseSourceControlLog", entityMapping: "IntegrationAssets"))
        asset_asset.relationshipMappings?.append(NSPropertyMapping(name: "inverseTriggerAssets", entityMapping: "IntegrationAssets"))
        asset_asset.relationshipMappings?.append(NSPropertyMapping(name: "inverseXcodebuildLog", entityMapping: "IntegrationAssets"))
        asset_asset.relationshipMappings?.append(NSPropertyMapping(name: "inverseXcodebuildOutput", entityMapping: "IntegrationAssets"))
        
        let bot_bot = NSEntityMapping(entityName: "Bot", sourceModel: sourceModel, destinationModel: destinationModel)
        bot_bot.attributeMappings?.append(NSPropertyMapping(name: "identifier"))
        bot_bot.attributeMappings?.append(NSPropertyMapping(name: "lastUpdate"))
        bot_bot.attributeMappings?.append(NSPropertyMapping(name: "name"))
        bot_bot.attributeMappings?.append(NSPropertyMapping(name: "revision"))
        bot_bot.attributeMappings?.append(NSPropertyMapping(name: "type"))
        bot_bot.relationshipMappings?.append(NSPropertyMapping(name: "configuration", entityMapping: "Configuration"))
        bot_bot.relationshipMappings?.append(NSPropertyMapping(name: "integrations", entityMapping: "Integration"))
        bot_bot.relationshipMappings?.append(NSPropertyMapping(name: "stats", entityMapping: "Stats"))
        bot_bot.relationshipMappings?.append(NSPropertyMapping(name: "xcodeServer", entityMapping: "XcodeServer"))
        
        let buildResultSummary_buildResultSummary = NSEntityMapping(entityName: "BuildResultSummary", sourceModel: sourceModel, destinationModel: destinationModel)
        buildResultSummary_buildResultSummary.attributeMappings?.append(NSPropertyMapping(name: "analyzerWarningChange"))
        buildResultSummary_buildResultSummary.attributeMappings?.append(NSPropertyMapping(name: "analyzerWarningCount"))
        buildResultSummary_buildResultSummary.attributeMappings?.append(NSPropertyMapping(name: "codeCoveragePercentage"))
        buildResultSummary_buildResultSummary.attributeMappings?.append(NSPropertyMapping(name: "codeCoveragePercentageDelta"))
        buildResultSummary_buildResultSummary.attributeMappings?.append(NSPropertyMapping(name: "errorChange"))
        buildResultSummary_buildResultSummary.attributeMappings?.append(NSPropertyMapping(name: "errorCount"))
        buildResultSummary_buildResultSummary.attributeMappings?.append(NSPropertyMapping(name: "improvedPerfTestCount"))
        buildResultSummary_buildResultSummary.attributeMappings?.append(NSPropertyMapping(name: "regressedPerfTestCount"))
        buildResultSummary_buildResultSummary.attributeMappings?.append(NSPropertyMapping(name: "testFailureChange"))
        buildResultSummary_buildResultSummary.attributeMappings?.append(NSPropertyMapping(name: "testFailureCount"))
        buildResultSummary_buildResultSummary.attributeMappings?.append(NSPropertyMapping(name: "testsChange"))
        buildResultSummary_buildResultSummary.attributeMappings?.append(NSPropertyMapping(name: "testsCount"))
        buildResultSummary_buildResultSummary.attributeMappings?.append(NSPropertyMapping(name: "warningChange"))
        buildResultSummary_buildResultSummary.attributeMappings?.append(NSPropertyMapping(name: "warningCount"))
        buildResultSummary_buildResultSummary.relationshipMappings?.append(NSPropertyMapping(name: "integration", entityMapping: "Integration"))
        
        let commit_commit = NSEntityMapping(entityName: "Commit", sourceModel: sourceModel, destinationModel: destinationModel)
        commit_commit.attributeMappings?.append(NSPropertyMapping(name: "commitHash"))
        commit_commit.attributeMappings?.append(NSPropertyMapping(name: "message"))
        commit_commit.attributeMappings?.append(NSPropertyMapping(name: "timestamp"))
        commit_commit.relationshipMappings?.append(NSPropertyMapping(name: "commitChanges", entityMapping: "CommitChange"))
        commit_commit.relationshipMappings?.append(NSPropertyMapping(name: "commitContributor", entityMapping: "CommitContributor"))
        commit_commit.relationshipMappings?.append(NSPropertyMapping(name: "repository", entityMapping: "Repository"))
        commit_commit.relationshipMappings?.append(NSPropertyMapping(name: "revisionBlueprints", entityMapping: "RevisionBlueprint"))
        
        let commitChange_commitChange = NSEntityMapping(entityName: "CommitChange", sourceModel: sourceModel, destinationModel: destinationModel)
        commitChange_commitChange.attributeMappings?.append(NSPropertyMapping(name: "filePath"))
        commitChange_commitChange.attributeMappings?.append(NSPropertyMapping(name: "status"))
        commitChange_commitChange.relationshipMappings?.append(NSPropertyMapping(name: "commit", entityMapping: "Commit"))
        
        let commitContributor_commitContributor = NSEntityMapping(entityName: "CommitContributor", sourceModel: sourceModel, destinationModel: destinationModel)
        commitContributor_commitContributor.attributeMappings?.append(NSPropertyMapping(name: "displayName"))
        commitContributor_commitContributor.attributeMappings?.append(NSPropertyMapping(name: "emailsData"))
        commitContributor_commitContributor.attributeMappings?.append(NSPropertyMapping(name: "name"))
        commitContributor_commitContributor.relationshipMappings?.append(NSPropertyMapping(name: "commit", entityMapping: "Commit"))
        
        let conditions_conditions = NSEntityMapping(entityName: "Conditions", sourceModel: sourceModel, destinationModel: destinationModel)
        conditions_conditions.attributeMappings?.append(NSPropertyMapping(name: "onAllIssuesResolved"))
        conditions_conditions.attributeMappings?.append(NSPropertyMapping(name: "onAnalyzerWarnings"))
        conditions_conditions.attributeMappings?.append(NSPropertyMapping(name: "onBuildErrors"))
        conditions_conditions.attributeMappings?.append(NSPropertyMapping(name: "onFailingTests"))
        conditions_conditions.attributeMappings?.append(NSPropertyMapping(name: "onInternalErrors"))
        conditions_conditions.attributeMappings?.append(NSPropertyMapping(name: "onSuccess"))
        conditions_conditions.attributeMappings?.append(NSPropertyMapping(name: "onWarnings"))
        conditions_conditions.attributeMappings?.append(NSPropertyMapping(name: "status"))
        conditions_conditions.relationshipMappings?.append(NSPropertyMapping(name: "trigger", entityMapping: "Trigger"))
        
        let configuration_configuration = NSEntityMapping(entityName: "Configuration", sourceModel: sourceModel, destinationModel: destinationModel)
        configuration_configuration.attributeMappings?.append(NSPropertyMapping(name: "builtFromClean"))
        configuration_configuration.attributeMappings?.append(NSPropertyMapping(name: "codeCoveragePreference"))
        configuration_configuration.attributeMappings?.append(NSPropertyMapping(name: "hourOfIntegration"))
        configuration_configuration.attributeMappings?.append(NSPropertyMapping(name: "minutesAfterHourToIntegrate"))
        configuration_configuration.attributeMappings?.append(NSPropertyMapping(name: "performsAnalyzeAction"))
        configuration_configuration.attributeMappings?.append(NSPropertyMapping(name: "performsArchiveAction"))
        configuration_configuration.attributeMappings?.append(NSPropertyMapping(name: "performsTestAction"))
        configuration_configuration.attributeMappings?.append(NSPropertyMapping(name: "periodicScheduleInterval"))
        configuration_configuration.attributeMappings?.append(NSPropertyMapping(name: "scheduleType"))
        configuration_configuration.attributeMappings?.append(NSPropertyMapping(name: "schemeName"))
        configuration_configuration.attributeMappings?.append(NSPropertyMapping(name: "testingDestinationType"))
        configuration_configuration.attributeMappings?.append(NSPropertyMapping(name: "weeklyScheduleDay"))
        configuration_configuration.relationshipMappings?.append(NSPropertyMapping(name: "bot", entityMapping: "Bot"))
        configuration_configuration.relationshipMappings?.append(NSPropertyMapping(name: "deviceSpecification", entityMapping: "DeviceSpecification"))
        configuration_configuration.relationshipMappings?.append(NSPropertyMapping(name: "repositories", entityMapping: "Repository"))
        configuration_configuration.relationshipMappings?.append(NSPropertyMapping(name: "triggers", entityMapping: "Trigger"))
        
        let device_device = NSEntityMapping(entityName: "Device", sourceModel: sourceModel, destinationModel: destinationModel)
        device_device.attributeMappings?.append(NSPropertyMapping(name: "architecture"))
        device_device.attributeMappings?.append(NSPropertyMapping(name: "connected"))
        device_device.attributeMappings?.append(NSPropertyMapping(name: "deviceID"))
        device_device.attributeMappings?.append(NSPropertyMapping(name: "deviceType"))
        device_device.attributeMappings?.append(NSPropertyMapping(name: "enabledForDevelopment"))
        device_device.attributeMappings?.append(NSPropertyMapping(name: "identifier"))
        device_device.attributeMappings?.append(NSPropertyMapping(name: "isServer"))
        device_device.attributeMappings?.append(NSPropertyMapping(name: "modelCode"))
        device_device.attributeMappings?.append(NSPropertyMapping(name: "modelName"))
        device_device.attributeMappings?.append(NSPropertyMapping(name: "modelUTI"))
        device_device.attributeMappings?.append(NSPropertyMapping(name: "name"))
        device_device.attributeMappings?.append(NSPropertyMapping(name: "osVersion"))
        device_device.attributeMappings?.append(NSPropertyMapping(name: "platformIdentifier"))
        device_device.attributeMappings?.append(NSPropertyMapping(name: "retina"))
        device_device.attributeMappings?.append(NSPropertyMapping(name: "simulator"))
        device_device.attributeMappings?.append(NSPropertyMapping(name: "supported"))
        device_device.attributeMappings?.append(NSPropertyMapping(name: "trusted"))
        device_device.relationshipMappings?.append(NSPropertyMapping(name: "activeProxiedDevice", entityMapping: "Device"))
        device_device.relationshipMappings?.append(NSPropertyMapping(name: "deviceSpecifications", entityMapping: "DeviceSpecification"))
        device_device.relationshipMappings?.append(NSPropertyMapping(name: "integrations", entityMapping: "Integration"))
        device_device.relationshipMappings?.append(NSPropertyMapping(name: "inverseActiveProxiedDevice", entityMapping: "Device"))
        
        let deviceSpecification_deviceSpecification = NSEntityMapping(entityName: "DeviceSpecification", sourceModel: sourceModel, destinationModel: destinationModel)
        deviceSpecification_deviceSpecification.relationshipMappings?.append(NSPropertyMapping(name: "configuration", entityMapping: "Configuration"))
        deviceSpecification_deviceSpecification.relationshipMappings?.append(NSPropertyMapping(name: "devices", entityMapping: "Device"))
        deviceSpecification_deviceSpecification.relationshipMappings?.append(NSPropertyMapping(name: "filters", entityMapping: "Filter"))
        
        let emailConfiguration_emailConfiguration = NSEntityMapping(entityName: "EmailConfiguration", sourceModel: sourceModel, destinationModel: destinationModel)
        emailConfiguration_emailConfiguration.attributeMappings?.append(NSPropertyMapping(name: "additionalRecipients"))
        emailConfiguration_emailConfiguration.attributeMappings?.append(NSPropertyMapping(name: "emailCommitters"))
        emailConfiguration_emailConfiguration.attributeMappings?.append(NSPropertyMapping(name: "includeCommitMessage"))
        emailConfiguration_emailConfiguration.attributeMappings?.append(NSPropertyMapping(name: "includeIssueDetails"))
        emailConfiguration_emailConfiguration.relationshipMappings?.append(NSPropertyMapping(name: "trigger", entityMapping: "Trigger"))
        
        let filter_filter = NSEntityMapping(entityName: "Filter", sourceModel: sourceModel, destinationModel: destinationModel)
        filter_filter.attributeMappings?.append(NSPropertyMapping(name: "architectureType"))
        filter_filter.attributeMappings?.append(NSPropertyMapping(name: "filterType"))
        filter_filter.relationshipMappings?.append(NSPropertyMapping(name: "deviceSpecification", entityMapping: "DeviceSpecification"))
        filter_filter.relationshipMappings?.append(NSPropertyMapping(name: "platform", entityMapping: "Platform"))
        
        let integration_integration = NSEntityMapping(entityName: "Integration", sourceModel: sourceModel, destinationModel: destinationModel)
        integration_integration.attributeMappings?.append(NSPropertyMapping(name: "currentStep"))
        integration_integration.attributeMappings?.append(NSPropertyMapping(name: "duration"))
        integration_integration.attributeMappings?.append(NSPropertyMapping(name: "endedTime"))
        integration_integration.attributeMappings?.append(NSPropertyMapping(name: "hasRetrievedAssets"))
        integration_integration.attributeMappings?.append(NSPropertyMapping(name: "hasRetrievedCommits"))
        integration_integration.attributeMappings?.append(NSPropertyMapping(name: "hasRetrievedIssues"))
        integration_integration.attributeMappings?.append(NSPropertyMapping(name: "identifier"))
        integration_integration.attributeMappings?.append(NSPropertyMapping(name: "lastUpdate"))
        integration_integration.attributeMappings?.append(NSPropertyMapping(name: "number"))
        integration_integration.attributeMappings?.append(NSPropertyMapping(name: "queuedDate"))
        integration_integration.attributeMappings?.append(NSPropertyMapping(name: "result"))
        integration_integration.attributeMappings?.append(NSPropertyMapping(name: "revision"))
        integration_integration.attributeMappings?.append(NSPropertyMapping(name: "shouldClean"))
        integration_integration.attributeMappings?.append(NSPropertyMapping(name: "startedTime"))
        integration_integration.attributeMappings?.append(NSPropertyMapping(name: "successStreak"))
        integration_integration.attributeMappings?.append(NSPropertyMapping(name: "testHierarchy", sourceName: "testHierachy"))
        integration_integration.attributeMappings?.append(NSPropertyMapping(name: "testHierarchyData", sourceName: "testHierachyData"))
        integration_integration.relationshipMappings?.append(NSPropertyMapping(name: "assets", entityMapping: "IntegrationAssets"))
        integration_integration.relationshipMappings?.append(NSPropertyMapping(name: "bot", entityMapping: "Bot"))
        integration_integration.relationshipMappings?.append(NSPropertyMapping(name: "buildResultSummary", entityMapping: "BuildResultSummary"))
        integration_integration.relationshipMappings?.append(NSPropertyMapping(name: "inverseBestSuccessStreak", entityMapping: "Stats"))
        integration_integration.relationshipMappings?.append(NSPropertyMapping(name: "inverseLastCleanIntegration", entityMapping: "Stats"))
        integration_integration.relationshipMappings?.append(NSPropertyMapping(name: "issues", entityMapping: "IntegrationIssues"))
        integration_integration.relationshipMappings?.append(NSPropertyMapping(name: "revisionBlueprints", entityMapping: "RevisionBlueprint"))
        integration_integration.relationshipMappings?.append(NSPropertyMapping(name: "testedDevices", entityMapping: "Device"))
        
        let integrationAssets_integrationAssets = NSEntityMapping(entityName: "IntegrationAssets", sourceModel: sourceModel, destinationModel: destinationModel)
        integrationAssets_integrationAssets.relationshipMappings?.append(NSPropertyMapping(name: "archive", entityMapping: "Asset"))
        integrationAssets_integrationAssets.relationshipMappings?.append(NSPropertyMapping(name: "buildServiceLog", entityMapping: "Asset"))
        integrationAssets_integrationAssets.relationshipMappings?.append(NSPropertyMapping(name: "integration", entityMapping: "Asset"))
        integrationAssets_integrationAssets.relationshipMappings?.append(NSPropertyMapping(name: "product", entityMapping: "Asset"))
        integrationAssets_integrationAssets.relationshipMappings?.append(NSPropertyMapping(name: "sourceControlLog", entityMapping: "Asset"))
        integrationAssets_integrationAssets.relationshipMappings?.append(NSPropertyMapping(name: "triggerAssets", entityMapping: "Asset"))
        integrationAssets_integrationAssets.relationshipMappings?.append(NSPropertyMapping(name: "xcodebuildLog", entityMapping: "Asset"))
        integrationAssets_integrationAssets.relationshipMappings?.append(NSPropertyMapping(name: "xcodebuildOutput", entityMapping: "Asset"))
        
        let integrationIssues_integrationIssues = NSEntityMapping(entityName: "IntegrationIssues", sourceModel: sourceModel, destinationModel: destinationModel)
        integrationIssues_integrationIssues.relationshipMappings?.append(NSPropertyMapping(name: "buildServiceErrors", entityMapping: "Issue"))
        integrationIssues_integrationIssues.relationshipMappings?.append(NSPropertyMapping(name: "buildServiceWarnings", entityMapping: "Issue"))
        integrationIssues_integrationIssues.relationshipMappings?.append(NSPropertyMapping(name: "freshAnalyzerWarnings", entityMapping: "Issue"))
        integrationIssues_integrationIssues.relationshipMappings?.append(NSPropertyMapping(name: "freshErrors", entityMapping: "Issue"))
        integrationIssues_integrationIssues.relationshipMappings?.append(NSPropertyMapping(name: "freshTestFailures", entityMapping: "Issue"))
        integrationIssues_integrationIssues.relationshipMappings?.append(NSPropertyMapping(name: "freshWarnings", entityMapping: "Issue"))
        integrationIssues_integrationIssues.relationshipMappings?.append(NSPropertyMapping(name: "integration", entityMapping: "Integration"))
        integrationIssues_integrationIssues.relationshipMappings?.append(NSPropertyMapping(name: "resolvedAnalyzerWarnings", entityMapping: "Issue"))
        integrationIssues_integrationIssues.relationshipMappings?.append(NSPropertyMapping(name: "resolvedErrors", entityMapping: "Issue"))
        integrationIssues_integrationIssues.relationshipMappings?.append(NSPropertyMapping(name: "resolvedTestFailures", entityMapping: "Issue"))
        integrationIssues_integrationIssues.relationshipMappings?.append(NSPropertyMapping(name: "resolvedWarnings", entityMapping: "Issue"))
        integrationIssues_integrationIssues.relationshipMappings?.append(NSPropertyMapping(name: "unresolvedAnalyzerWarnings", entityMapping: "Issue"))
        integrationIssues_integrationIssues.relationshipMappings?.append(NSPropertyMapping(name: "unresolvedErrors", entityMapping: "Issue"))
        integrationIssues_integrationIssues.relationshipMappings?.append(NSPropertyMapping(name: "unresolvedTestFailures", entityMapping: "Issue"))
        integrationIssues_integrationIssues.relationshipMappings?.append(NSPropertyMapping(name: "unresolvedWarnings", entityMapping: "Issue"))
        
        let issue_issue = NSEntityMapping(entityName: "Issue", sourceModel: sourceModel, destinationModel: destinationModel)
        issue_issue.attributeMappings?.append(NSPropertyMapping(name: "age"))
        issue_issue.attributeMappings?.append(NSPropertyMapping(name: "documentFilePath"))
        issue_issue.attributeMappings?.append(NSPropertyMapping(name: "documentLocationData"))
        issue_issue.attributeMappings?.append(NSPropertyMapping(name: "identifier"))
        issue_issue.attributeMappings?.append(NSPropertyMapping(name: "issueType"))
        issue_issue.attributeMappings?.append(NSPropertyMapping(name: "lineNumber"))
        issue_issue.attributeMappings?.append(NSPropertyMapping(name: "message"))
        issue_issue.attributeMappings?.append(NSPropertyMapping(name: "revision"))
        issue_issue.attributeMappings?.append(NSPropertyMapping(name: "status"))
        issue_issue.attributeMappings?.append(NSPropertyMapping(name: "target"))
        issue_issue.attributeMappings?.append(NSPropertyMapping(name: "testCase"))
        issue_issue.attributeMappings?.append(NSPropertyMapping(name: "type"))
        issue_issue.relationshipMappings?.append(NSPropertyMapping(name: "inverseBuildServiceErrors", entityMapping: "IntegrationIssues"))
        issue_issue.relationshipMappings?.append(NSPropertyMapping(name: "inverseBuildServiceWarnings", entityMapping: "IntegrationIssues"))
        issue_issue.relationshipMappings?.append(NSPropertyMapping(name: "inverseFreshAnalyzerWarnings", entityMapping: "IntegrationIssues"))
        issue_issue.relationshipMappings?.append(NSPropertyMapping(name: "inverseFreshErrors", entityMapping: "IntegrationIssues"))
        issue_issue.relationshipMappings?.append(NSPropertyMapping(name: "inverseFreshTestFailures", entityMapping: "IntegrationIssues"))
        issue_issue.relationshipMappings?.append(NSPropertyMapping(name: "inverseFreshWarnings", entityMapping: "IntegrationIssues"))
        issue_issue.relationshipMappings?.append(NSPropertyMapping(name: "inverseResolvedAnalyzerWarnings", entityMapping: "IntegrationIssues"))
        issue_issue.relationshipMappings?.append(NSPropertyMapping(name: "inverseResolvedErrors", entityMapping: "IntegrationIssues"))
        issue_issue.relationshipMappings?.append(NSPropertyMapping(name: "inverseResolvedTestFailures", entityMapping: "IntegrationIssues"))
        issue_issue.relationshipMappings?.append(NSPropertyMapping(name: "inverseResolvedWarnings", entityMapping: "IntegrationIssues"))
        issue_issue.relationshipMappings?.append(NSPropertyMapping(name: "inverseUnresolvedAnalyzerWarnings", entityMapping: "IntegrationIssues"))
        issue_issue.relationshipMappings?.append(NSPropertyMapping(name: "inverseUnresolvedErrors", entityMapping: "IntegrationIssues"))
        issue_issue.relationshipMappings?.append(NSPropertyMapping(name: "inverseUnresolvedTestFailures", entityMapping: "IntegrationIssues"))
        issue_issue.relationshipMappings?.append(NSPropertyMapping(name: "inverseUnresolvedWarnings", entityMapping: "IntegrationIssues"))
        
        let platform_platform = NSEntityMapping(entityName: "Platform", sourceModel: sourceModel, destinationModel: destinationModel)
        platform_platform.attributeMappings?.append(NSPropertyMapping(name: "buildNumber"))
        platform_platform.attributeMappings?.append(NSPropertyMapping(name: "displayName"))
        platform_platform.attributeMappings?.append(NSPropertyMapping(name: "identifier"))
        platform_platform.attributeMappings?.append(NSPropertyMapping(name: "platformIdentifier"))
        platform_platform.attributeMappings?.append(NSPropertyMapping(name: "revision"))
        platform_platform.attributeMappings?.append(NSPropertyMapping(name: "simulatorIdentifier"))
        platform_platform.attributeMappings?.append(NSPropertyMapping(name: "version"))
        platform_platform.relationshipMappings?.append(NSPropertyMapping(name: "filter", entityMapping: "Filter"))
        
        let repository_repository = NSEntityMapping(entityName: "Repository", sourceModel: sourceModel, destinationModel: destinationModel)
        repository_repository.attributeMappings?.append(NSPropertyMapping(name: "branchIdentifier"))
        repository_repository.attributeMappings?.append(NSPropertyMapping(name: "branchOptions"))
        repository_repository.attributeMappings?.append(NSPropertyMapping(name: "identifier"))
        repository_repository.attributeMappings?.append(NSPropertyMapping(name: "locationType"))
        repository_repository.attributeMappings?.append(NSPropertyMapping(name: "system"))
        repository_repository.attributeMappings?.append(NSPropertyMapping(name: "url"))
        repository_repository.attributeMappings?.append(NSPropertyMapping(name: "workingCopyPath"))
        repository_repository.attributeMappings?.append(NSPropertyMapping(name: "workingCopyState"))
        repository_repository.relationshipMappings?.append(NSPropertyMapping(name: "commits", entityMapping: "Commit"))
        repository_repository.relationshipMappings?.append(NSPropertyMapping(name: "configurations", entityMapping: "Configuration"))
        
        let revisionBlueprint_revisionBlueprint = NSEntityMapping(entityName: "RevisionBlueprint", sourceModel: sourceModel, destinationModel: destinationModel)
        revisionBlueprint_revisionBlueprint.relationshipMappings?.append(NSPropertyMapping(name: "commit", entityMapping: "Commit"))
        revisionBlueprint_revisionBlueprint.relationshipMappings?.append(NSPropertyMapping(name: "integration", entityMapping: "Integration"))
        
        let stats_stats = NSEntityMapping(entityName: "Stats", sourceModel: sourceModel, destinationModel: destinationModel)
        stats_stats.attributeMappings?.append(NSPropertyMapping(name: "codeCoveragePercentageDelta"))
        stats_stats.attributeMappings?.append(NSPropertyMapping(name: "numberOfCommits"))
        stats_stats.attributeMappings?.append(NSPropertyMapping(name: "numberOfIntegrations"))
        stats_stats.attributeMappings?.append(NSPropertyMapping(name: "sinceDate"))
        stats_stats.attributeMappings?.append(NSPropertyMapping(name: "testAdditionRate"))
        stats_stats.relationshipMappings?.append(NSPropertyMapping(name: "analysisWarnings", entityMapping: "StatsBreakdown"))
        stats_stats.relationshipMappings?.append(NSPropertyMapping(name: "averageIntegrationTime", entityMapping: "StatsBreakdown"))
        stats_stats.relationshipMappings?.append(NSPropertyMapping(name: "bestSuccessStreak", entityMapping: "Integration"))
        stats_stats.relationshipMappings?.append(NSPropertyMapping(name: "bot", entityMapping: "Bot"))
        stats_stats.relationshipMappings?.append(NSPropertyMapping(name: "errors", entityMapping: "StatsBreakdown"))
        stats_stats.relationshipMappings?.append(NSPropertyMapping(name: "improvedPerfTests", entityMapping: "StatsBreakdown"))
        stats_stats.relationshipMappings?.append(NSPropertyMapping(name: "lastCleanIntegration", entityMapping: "Integration"))
        stats_stats.relationshipMappings?.append(NSPropertyMapping(name: "regressedPeftTests", entityMapping: "StatsBreakdown"))
        stats_stats.relationshipMappings?.append(NSPropertyMapping(name: "testFailures", entityMapping: "StatsBreakdown"))
        stats_stats.relationshipMappings?.append(NSPropertyMapping(name: "tests", entityMapping: "StatsBreakdown"))
        stats_stats.relationshipMappings?.append(NSPropertyMapping(name: "warnings", entityMapping: "StatsBreakdown"))
        
        let statsBreakdown_statsBreakdown = NSEntityMapping(entityName: "StatsBreakdown", sourceModel: sourceModel, destinationModel: destinationModel)
        statsBreakdown_statsBreakdown.attributeMappings?.append(NSPropertyMapping(name: "avg"))
        statsBreakdown_statsBreakdown.attributeMappings?.append(NSPropertyMapping(name: "count"))
        statsBreakdown_statsBreakdown.attributeMappings?.append(NSPropertyMapping(name: "max"))
        statsBreakdown_statsBreakdown.attributeMappings?.append(NSPropertyMapping(name: "min"))
        statsBreakdown_statsBreakdown.attributeMappings?.append(NSPropertyMapping(name: "stdDev"))
        statsBreakdown_statsBreakdown.attributeMappings?.append(NSPropertyMapping(name: "sum"))
        statsBreakdown_statsBreakdown.relationshipMappings?.append(NSPropertyMapping(name: "inverseAnalysisWarnings", entityMapping: "Stats"))
        statsBreakdown_statsBreakdown.relationshipMappings?.append(NSPropertyMapping(name: "inverseAverageIntegrationTime", entityMapping: "Stats"))
        statsBreakdown_statsBreakdown.relationshipMappings?.append(NSPropertyMapping(name: "inverseErrors", entityMapping: "Stats"))
        statsBreakdown_statsBreakdown.relationshipMappings?.append(NSPropertyMapping(name: "inverseImprovedPerfTests", entityMapping: "Stats"))
        statsBreakdown_statsBreakdown.relationshipMappings?.append(NSPropertyMapping(name: "inverseRegressedPerfTests", entityMapping: "Stats"))
        statsBreakdown_statsBreakdown.relationshipMappings?.append(NSPropertyMapping(name: "inverseTestFailures", entityMapping: "Stats"))
        statsBreakdown_statsBreakdown.relationshipMappings?.append(NSPropertyMapping(name: "inverseTests", entityMapping: "Stats"))
        statsBreakdown_statsBreakdown.relationshipMappings?.append(NSPropertyMapping(name: "inverseWarnings", entityMapping: "Stats"))
        
        let trigger_trigger = NSEntityMapping(entityName: "Trigger", sourceModel: sourceModel, destinationModel: destinationModel)
        trigger_trigger.attributeMappings?.append(NSPropertyMapping(name: "name"))
        trigger_trigger.attributeMappings?.append(NSPropertyMapping(name: "phase"))
        trigger_trigger.attributeMappings?.append(NSPropertyMapping(name: "scriptBody"))
        trigger_trigger.attributeMappings?.append(NSPropertyMapping(name: "type"))
        trigger_trigger.relationshipMappings?.append(NSPropertyMapping(name: "conditions", entityMapping: "Conditions"))
        trigger_trigger.relationshipMappings?.append(NSPropertyMapping(name: "configuration", entityMapping: "Configuration"))
        trigger_trigger.relationshipMappings?.append(NSPropertyMapping(name: "emailConfiguration", entityMapping: "EmailConfiguration"))
        
        let xcodeServer_xcodeServer = NSEntityMapping(entityName: "XcodeServer", sourceModel: sourceModel, destinationModel: destinationModel)
        xcodeServer_xcodeServer.attributeMappings?.append(NSPropertyMapping(name: "apiVersion"))
        xcodeServer_xcodeServer.attributeMappings?.append(NSPropertyMapping(name: "fqdn"))
        xcodeServer_xcodeServer.attributeMappings?.append(NSPropertyMapping(name: "lastUpdate"))
        xcodeServer_xcodeServer.attributeMappings?.append(NSPropertyMapping(name: "os"))
        xcodeServer_xcodeServer.attributeMappings?.append(NSPropertyMapping(name: "server"))
        xcodeServer_xcodeServer.attributeMappings?.append(NSPropertyMapping(name: "xcode"))
        xcodeServer_xcodeServer.attributeMappings?.append(NSPropertyMapping(name: "xcodeServer"))
        xcodeServer_xcodeServer.relationshipMappings?.append(NSPropertyMapping(name: "bots", entityMapping: "Bot"))
        
        entityMappings = [
            asset_asset, bot_bot, buildResultSummary_buildResultSummary, commit_commit, commitChange_commitChange,
            commitContributor_commitContributor, conditions_conditions, configuration_configuration, device_device,
            deviceSpecification_deviceSpecification, emailConfiguration_emailConfiguration, filter_filter, integration_integration,
            integrationAssets_integrationAssets, integrationIssues_integrationIssues, issue_issue, platform_platform,
            repository_repository, revisionBlueprint_revisionBlueprint, stats_stats, statsBreakdown_statsBreakdown,
            trigger_trigger, xcodeServer_xcodeServer
        ]
    }
}
