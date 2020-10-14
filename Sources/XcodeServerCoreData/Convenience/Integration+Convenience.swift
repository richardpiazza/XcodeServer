import XcodeServer
#if canImport(CoreData)
import CoreData

public extension Integration {
    private static var jsonEncoder: JSONEncoder = JSONEncoder()
    private static var jsonDecoder: JSONDecoder = JSONDecoder()
    
    var integrationNumber: Int {
        return Int(number)
    }
    
    var currentStep: XcodeServer.Integration.Step {
        get {
            return XcodeServer.Integration.Step(rawValue: currentStepRawValue ?? "") ?? .pending
        }
        set {
            currentStepRawValue = newValue.rawValue
        }
    }
    
    var result: XcodeServer.Integration.Result {
        get {
            return XcodeServer.Integration.Result(rawValue: resultRawValue ?? "") ?? .canceled
        }
        set {
            resultRawValue = newValue.rawValue
        }
    }
    
    var testHierarchy: Tests.Hierarchy? {
        get {
            guard let data = testHierarchyData else {
                return nil
            }
            
            do {
                return try Self.jsonDecoder.decode(Tests.Hierarchy.self, from: data)
            } catch {
                InternalLog.coreData.error("", error: error)
            }
            
            return nil
        }
        set {
            guard let value = newValue else {
                testHierarchyData = nil
                return
            }
            
            do {
                testHierarchyData = try Self.jsonEncoder.encode(value)
            } catch {
                InternalLog.coreData.error("", error: error)
            }
        }
    }
    
    var testResults: [Tests.Results] {
        guard let testHierarchy = self.testHierarchy else {
            return []
        }
        
        guard testHierarchy.suites.count > 0 else {
            return []
        }
        
        var results: [Tests.Results] = []
        for suite in testHierarchy.suites {
            for `class` in suite.classes {
                for method in `class`.methods {
                    let result: Tests.Result = (method.hasFailures) ? .failed : .passed
                    results.append(Tests.Results(name: method.methodName, result: result))
                }
            }
        }
        
        return results
    }
    
    var commits: [Commit] {
        var commits: [Commit] = []
        guard let revisionBlueprints = self.revisionBlueprints else {
            return commits
        }
        
        for blueprint in revisionBlueprints {
            if let commit = blueprint.commit {
                commits.append(commit)
            }
        }
        
        return commits
    }
}

public extension XcodeServerCoreData.Integration {
    func update(_ integration: XcodeServer.Integration, context: NSManagedObjectContext) {
        if assets == nil {
            assets = IntegrationAssets(context: context)
        }
        if buildResultSummary == nil {
            buildResultSummary = BuildResultSummary(context: context)
        }
        if issues == nil {
            issues = IntegrationIssues(context: context)
        }
        
        currentStep = integration.step
        duration = integration.duration ?? 0.0
        endedTime = integration.ended
        identifier = integration.id
        lastUpdate = integration.modified
        number = Int32(integration.number)
        queuedDate = integration.queued
        result = integration.result
        shouldClean = integration.shouldClean
        startedTime = integration.started
        successStreak = Int32(integration.successStreak)
        
        if let tests = integration.testHierarchy {
            testHierarchy = tests
        }
        
        if let catalog = integration.assets {
            assets?.update(catalog, context: context)
        }
        
        if let summary = integration.buildSummary {
            buildResultSummary?.update(summary)
        }
        
        if let issues = integration.issues {
            self.issues?.update(issues, context: context)
        }
        
        if let commits = integration.commits {
            update(commits, context: context)
        }
        
        // TODO: When core data model supports it.
        _ = integration.controlledChanges
        
        if let blueprint = integration.revisionBlueprint {
            if !blueprint.primaryRemoteIdentifier.isEmpty {
                let repository = context.repository(withIdentifier: blueprint.primaryRemoteIdentifier) ?? Repository(context: context)
                repository.update(blueprint, context: context)
            }
        }
        
        if !integration.shouldRetrieveArchive {
            hasRetrievedAssets = true
        }
        if !integration.shouldRetrieveIssues {
            hasRetrievedIssues = true
        }
        if !integration.shouldRetrieveCommits {
            hasRetrievedCommits = true
        }
    }
    
    func update(_ commits: Set<SourceControl.Commit>, context: NSManagedObjectContext) {
        commits.forEach { (commit) in
            guard let remoteId = commit.remoteId else {
                InternalLog.coreData.warn("No Remote ID for commit: \(commit)")
                return
            }
            
            let repository: Repository
            if let entity = context.repository(withIdentifier: remoteId) {
                repository = entity
            } else {
                repository = Repository(context: context)
                repository.identifier = remoteId
            }
            
            repository.update(commits, integration: self, context: context)
        }
    }
}
#endif
