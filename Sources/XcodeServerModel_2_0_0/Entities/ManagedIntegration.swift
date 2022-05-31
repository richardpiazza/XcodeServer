import Foundation
import CoreDataPlus
import XcodeServer
#if canImport(CoreData)
import CoreData

public class ManagedIntegration: NSManagedObject {

}

extension ManagedIntegration {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedIntegration> {
        return NSFetchRequest<ManagedIntegration>(entityName: "ManagedIntegration")
    }

    @NSManaged public var currentStepRawValue: String?
    @NSManaged public var duration: Double
    @NSManaged public var endedTime: Date?
    @NSManaged public var hasRetrievedAssets: Bool
    @NSManaged public var hasRetrievedCommits: Bool
    @NSManaged public var hasRetrievedIssues: Bool
    @NSManaged public var identifier: String?
    @NSManaged public var lastUpdate: Date?
    @NSManaged public var number: Int32
    @NSManaged public var queuedDate: Date?
    @NSManaged public var resultRawValue: String?
    @NSManaged public var revision: String?
    @NSManaged public var shouldClean: Bool
    @NSManaged public var startedTime: Date?
    @NSManaged public var successStreak: Int32
    @NSManaged public var testHierarchyData: Data?
    @NSManaged public var assets: ManagedIntegrationAssets?
    @NSManaged public var bot: ManagedBot?
    @NSManaged public var buildResultSummary: ManagedBuildResultSummary?
    @NSManaged public var inverseBestSuccessStreak: ManagedStats?
    @NSManaged public var inverseLastCleanIntegration: ManagedStats?
    @NSManaged public var issues: ManagedIntegrationIssues?
    @NSManaged public var revisionBlueprints: NSSet?
    @NSManaged public var testedDevices: NSSet?

}

// MARK: Generated accessors for revisionBlueprints
extension ManagedIntegration {

    @objc(addRevisionBlueprintsObject:)
    @NSManaged public func addToRevisionBlueprints(_ value: ManagedRevisionBlueprint)

    @objc(removeRevisionBlueprintsObject:)
    @NSManaged public func removeFromRevisionBlueprints(_ value: ManagedRevisionBlueprint)

    @objc(addRevisionBlueprints:)
    @NSManaged public func addToRevisionBlueprints(_ values: NSSet)

    @objc(removeRevisionBlueprints:)
    @NSManaged public func removeFromRevisionBlueprints(_ values: NSSet)

}

// MARK: Generated accessors for testedDevices
extension ManagedIntegration {

    @objc(addTestedDevicesObject:)
    @NSManaged public func addToTestedDevices(_ value: ManagedDevice)

    @objc(removeTestedDevicesObject:)
    @NSManaged public func removeFromTestedDevices(_ value: ManagedDevice)

    @objc(addTestedDevices:)
    @NSManaged public func addToTestedDevices(_ values: NSSet)

    @objc(removeTestedDevices:)
    @NSManaged public func removeFromTestedDevices(_ values: NSSet)

}

extension ManagedIntegration {
    static func fetchIntegrations() -> NSFetchRequest<ManagedIntegration> {
        fetchRequest()
    }
    
    static func fetchIncompleteIntegrations() -> NSFetchRequest<ManagedIntegration> {
        let request = fetchRequest()
        request.predicate = NSPredicate(format: "%K != %@", #keyPath(ManagedIntegration.currentStepRawValue), Integration.Step.completed.rawValue)
        return request
    }
    
    static func fetchIntegrations(forBot id: Bot.ID) -> NSFetchRequest<ManagedIntegration> {
        let request = fetchRequest()
        request.predicate = NSPredicate(format: "%K = %@", #keyPath(ManagedIntegration.bot.identifier), id)
        return request
    }
    
    static func fetchIntegration(withId id: Integration.ID) -> NSFetchRequest<ManagedIntegration> {
        let request = fetchRequest()
        request.predicate = NSPredicate(format: "%K = %@", #keyPath(ManagedIntegration.identifier), id)
        return request
    }
    
    /// Retrieves the first `ManagedIntegration` entity from the Core Data `NSManagedObjectContext` that matches the specified id.
    static func integration(_ id: Integration.ID, in context: NSManagedObjectContext) -> ManagedIntegration? {
        let request = fetchRequest()
        request.predicate = NSPredicate(format: "%K = %@", #keyPath(ManagedIntegration.identifier), id)
        do {
            return try context.fetch(request).first
        } catch {
            PersistentContainer.logger.error("Failed to fetch `ManagedIntegration`.", metadata: [
                "Integration.ID": .string(id),
                "localizedDescription": .string(error.localizedDescription)
            ])
        }
        
        return nil
    }
    
    var integrationNumber: Int {
        return Int(number)
    }
    
    var currentStep: Integration.Step {
        get { Integration.Step(rawValue: currentStepRawValue ?? "") ?? .pending }
        set { currentStepRawValue = newValue.rawValue }
    }
    
    var result: Integration.Result {
        get { Integration.Result(rawValue: resultRawValue ?? "") ?? .canceled }
        set { resultRawValue = newValue.rawValue }
    }
    
    var testHierarchy: Tests.Hierarchy? {
        get {
            guard let data = testHierarchyData else {
                return nil
            }
            
            do {
                return try PersistentContainer.jsonDecoder.decode(Tests.Hierarchy.self, from: data)
            } catch {
                PersistentContainer.logger.error("Failed to decode 'testHierarchyData'.", metadata: [
                    "UTF8": .string(String(data: data, encoding: .utf8) ?? ""),
                    "localizedDescription": .string(error.localizedDescription)
                ])
            }
            
            return nil
        }
        set {
            guard let value = newValue else {
                testHierarchyData = nil
                return
            }
            
            do {
                testHierarchyData = try PersistentContainer.jsonEncoder.encode(value)
            } catch {
                PersistentContainer.logger.error("Failed to encode 'testHierarchyData'.", metadata: [
                    "UTF8": .string("\(value)"),
                    "localizedDescription": .string(error.localizedDescription)
                ])
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
    
    var commits: [ManagedCommit] {
        var commits: [ManagedCommit] = []
        guard let revisionBlueprints = self.revisionBlueprints as? Set<ManagedRevisionBlueprint> else {
            return commits
        }
        
        for blueprint in revisionBlueprints {
            if let commit = blueprint.commit {
                commits.append(commit)
            }
        }
        
        return commits
    }
    
    func update(_ integration: Integration, context: NSManagedObjectContext) {
        if assets == nil {
            PersistentContainer.logger.trace("Creating `ManagedIntegrationAssets`.", metadata: [
                "Integration.ID": .string(integration.id),
                "Integration.Number": .stringConvertible(integration.number)
            ])
            assets = context.make()
        }
        if buildResultSummary == nil {
            PersistentContainer.logger.trace("Creating `ManagedBuildResultSummary`.", metadata: [
                "Integration.ID": .string(integration.id),
                "Integration.Number": .stringConvertible(integration.number)
            ])
            buildResultSummary = context.make()
        }
        if issues == nil {
            PersistentContainer.logger.trace("Creating `ManagedIntegrationIssues`.", metadata: [
                "Integration.ID": .string(integration.id),
                "Integration.Number": .stringConvertible(integration.number)
            ])
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
                let repository: ManagedRepository
                if let entity = ManagedRepository.repository(blueprint.primaryRemoteIdentifier, in: context) {
                    repository = entity
                } else {
                    PersistentContainer.logger.trace("Creating `ManagedRepository`.", metadata: [
                        "Remote.ID": .string(blueprint.primaryRemoteIdentifier),
                        "Blueprint.ID": .string(blueprint.id),
                        "Blueprint.Name": .string(blueprint.name),
                    ])
                    repository = context.make()
                }
                repository.update(blueprint, context: context)
            }
        }
    }
    
    func update(_ commits: Set<SourceControl.Commit>, context: NSManagedObjectContext) {
        commits.forEach { (commit) in
            guard let remoteId = commit.remoteId, !remoteId.isEmpty else {
                PersistentContainer.logger.warning("No Remote ID for commit: \(commit)")
                return
            }
            
            let repository: ManagedRepository
            if let entity = ManagedRepository.repository(remoteId, in: context) {
                repository = entity
            } else {
                PersistentContainer.logger.trace("Creating `ManagedRepository`.", metadata: [
                    "Remote.ID": .string(remoteId),
                ])
                repository = context.make()
                repository.identifier = remoteId
            }
            
            repository.update(commits, integration: self, context: context)
        }
    }
}

extension Integration {
    init(_ integration: ManagedIntegration) {
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
            buildSummary = Integration.BuildSummary(summary)
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
