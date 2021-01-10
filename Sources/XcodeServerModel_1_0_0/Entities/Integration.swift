import XcodeServer
import XcodeServerCoreData
import Foundation
#if canImport(CoreData)
import CoreData

//@objc(Integration)
class Integration: NSManagedObject {

}

extension Integration {

    @nonobjc class func fetchRequest() -> NSFetchRequest<Integration> {
        return NSFetchRequest<Integration>(entityName: "Integration")
    }

    @NSManaged var currentStepRawValue: String?
    @NSManaged var duration: Double
    @NSManaged var endedTime: Date?
    @NSManaged var hasRetrievedAssets: Bool
    @NSManaged var hasRetrievedCommits: Bool
    @NSManaged var hasRetrievedIssues: Bool
    @NSManaged var identifier: String?
    @NSManaged var lastUpdate: Date?
    @NSManaged var number: Int32
    @NSManaged var queuedDate: Date?
    @NSManaged var resultRawValue: String?
    @NSManaged var revision: String?
    @NSManaged var shouldClean: Bool
    @NSManaged var startedTime: Date?
    @NSManaged var successStreak: Int32
    @NSManaged var testHierarchyData: Data?
    @NSManaged var assets: IntegrationAssets?
    @NSManaged var bot: Bot?
    @NSManaged var buildResultSummary: BuildResultSummary?
    @NSManaged var inverseBestSuccessStreak: Stats?
    @NSManaged var inverseLastCleanIntegration: Stats?
    @NSManaged var issues: IntegrationIssues?
    @NSManaged var revisionBlueprints: NSSet?
    @NSManaged var testedDevices: NSSet?

}

// MARK: Generated accessors for revisionBlueprints
extension Integration {

    @objc(addRevisionBlueprintsObject:)
    @NSManaged public func addToRevisionBlueprints(_ value: RevisionBlueprint)

    @objc(removeRevisionBlueprintsObject:)
    @NSManaged public func removeFromRevisionBlueprints(_ value: RevisionBlueprint)

    @objc(addRevisionBlueprints:)
    @NSManaged public func addToRevisionBlueprints(_ values: NSSet)

    @objc(removeRevisionBlueprints:)
    @NSManaged public func removeFromRevisionBlueprints(_ values: NSSet)

}

// MARK: Generated accessors for testedDevices
extension Integration {

    @objc(addTestedDevicesObject:)
    @NSManaged public func addToTestedDevices(_ value: Device)

    @objc(removeTestedDevicesObject:)
    @NSManaged public func removeFromTestedDevices(_ value: Device)

    @objc(addTestedDevices:)
    @NSManaged public func addToTestedDevices(_ values: NSSet)

    @objc(removeTestedDevices:)
    @NSManaged public func removeFromTestedDevices(_ values: NSSet)

}

extension Integration {
    /// Retrieves all `Integration` entities from the Core Data `NSManagedObjectContext`
    static func integrations(in context: NSManagedObjectContext) -> [Integration] {
        let request = NSFetchRequest<Integration>(entityName: entityName)
        do {
            return try context.fetch(request)
        } catch {
            InternalLog.coreData.error("Failed to fetch integrations", error: error)
        }
        
        return []
    }
    
    /// Retrieves all `Integration` entities for the specified `Bot`.
    static func integrations(forBot id: XcodeServer.Bot.ID, in context: NSManagedObjectContext) -> [Integration] {
        let request = NSFetchRequest<Integration>(entityName: entityName)
        request.predicate = NSPredicate(format: "bot.identifier = %@", argumentArray: [id])
        do {
            return try context.fetch(request)
        } catch {
            InternalLog.coreData.error("Failed to fetch integrations for bot '\(id)'", error: error)
        }
        
        return []
    }
    
    /// Retrieves the first `Integration` entity from the Core Data `NSManagedObjectContext` that matches the specified
    /// id.
    static func integration(_ id: XcodeServer.Integration.ID, in context: NSManagedObjectContext) -> Integration? {
        let request = NSFetchRequest<Integration>(entityName: entityName)
        request.predicate = NSPredicate(format: "identifier = %@", argumentArray: [id])
        do {
            return try context.fetch(request).first
        } catch {
            InternalLog.coreData.error("Failed to fetch integration '\(id)'", error: error)
        }
        
        return nil
    }
    
    /// All Integrations that are not in the 'completed' step.
    static func incompleteIntegrations(in context: NSManagedObjectContext) -> [Integration] {
        let request = NSFetchRequest<Integration>(entityName: entityName)
        request.predicate = NSPredicate(format: "currentStepRawValue != %@", argumentArray: [XcodeServer.Integration.Step.completed.rawValue])
        do {
            return try context.fetch(request)
        } catch {
            InternalLog.coreData.error("Failed to fetch incomplete integrations", error: error)
        }
        
        return []
    }
}

extension Integration {
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
        guard let revisionBlueprints = self.revisionBlueprints as? Set<RevisionBlueprint> else {
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

extension Integration {
    func update(_ integration: XcodeServer.Integration, context: NSManagedObjectContext) {
        if assets == nil {
            InternalLog.coreData.debug("Creating INTEGRATION_ASSETS for Integration '\(integration.number)' [\(integration.id)]")
            assets = context.make()
        }
        if buildResultSummary == nil {
            InternalLog.coreData.debug("Creating BUILD_RESULT_SUMMARY for Integration '\(integration.number)' [\(integration.id)]")
            buildResultSummary = context.make()
        }
        if issues == nil {
            InternalLog.coreData.debug("Creating INTEGRATION_ISSUES for Integration '\(integration.number)' [\(integration.id)]")
            issues = context.make()
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
                let repository: Repository
                if let entity = Repository.repository(blueprint.primaryRemoteIdentifier, in: context) {
                    repository = entity
                } else {
                    InternalLog.coreData.debug("Creating REPOSITORY '\(blueprint.name)' [\(blueprint.primaryRemoteIdentifier)]")
                    repository = context.make()
                }
                repository.update(blueprint, context: context)
            }
        }
    }
    
    func update(_ commits: Set<SourceControl.Commit>, context: NSManagedObjectContext) {
        commits.forEach { (commit) in
            guard let remoteId = commit.remoteId, !remoteId.isEmpty else {
                InternalLog.coreData.warn("No Remote ID for commit: \(commit)")
                return
            }
            
            let repository: Repository
            if let entity = Repository.repository(remoteId, in: context) {
                repository = entity
            } else {
                InternalLog.coreData.debug("Creating REPOSITORY '??' [\(remoteId)]")
                repository = context.make()
                repository.identifier = remoteId
            }
            
            repository.update(commits, integration: self, context: context)
        }
    }
}

extension XcodeServer.Integration {
    init(_ integration: Integration) {
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
    }
}
#endif
