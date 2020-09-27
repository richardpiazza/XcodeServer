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
                print(error)
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
                print(error)
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
        
        switch (buildResultSummary, integration.buildSummary) {
        case (.some(let managedSummary), .some(let summary)):
            managedSummary.update(summary)
        case (.none, .some(let summary)):
            buildResultSummary = BuildResultSummary(context: context)
            buildResultSummary?.update(summary)
        default:
            break
        }
        
        switch (assets, integration.assets) {
        case (.some(let managedAssets), .some(let update)):
            managedAssets.update(update, context: context)
        case (.none, .some(let update)):
            assets = IntegrationAssets(context: context)
            assets?.update(update, context: context)
        default:
            break
        }
        
        switch (issues, integration.issues) {
        case (.some(let managedIssues), .some(let update)):
            managedIssues.update(update, context: context)
        case (.none, .some(let update)):
            issues = IntegrationIssues(context: context)
            issues?.update(update, context: context)
        default:
            break
        }
        
        _ = integration.controlledChanges
        _ = integration.commits
    }
}

/*
 public extension XcodeServerCoreData.Integration {
     @discardableResult
     func update(withIntegration integration: XCSIntegration) -> [XcodeServerProcedureEvent] {
         var events: [XcodeServerProcedureEvent] = []
         
         guard let moc = self.managedObjectContext else {
             return events
         }
         
         let _currentStep = XcodeServer.Integration.Step(rawValue: integration.currentStep.rawValue) ?? .pending
         let _result = XcodeServer.Integration.Result(rawValue: integration.result.rawValue) ?? .unknown
         
         if (currentStep != _currentStep) || (result != _result) {
             events.append(.integration(action: .update, identifier: integration.id, number: integration.number))
         }
         
         self.currentStep = _currentStep
         self.duration = integration.duration ?? 0.0
         self.endedTime = integration.endedTime
         self.number = integration.number
         self.queuedDate = integration.queuedDate
         self.result = _result
         self.shouldClean = integration.shouldClean ?? false
         self.startedTime = integration.startedTime
         self.successStreak = integration.successStreak ?? 0
         
         if let value = integration.testHierarchy {
             self.testHierarchy = Tests.Hierarchy(value)
         }
         
         // Build Results Summary
         if let summary = integration.buildResultSummary {
             if self.buildResultSummary == nil {
                 self.buildResultSummary = BuildResultSummary(context: moc)
             }
             self.buildResultSummary?.update(withBuildResultSummary: summary)
         }
         
         // Assets
         if let assets = integration.assets {
             if self.assets == nil {
                 self.assets = IntegrationAssets(context: moc)
             }
             self.assets?.update(withIntegrationAssets: assets)
         }
         
         // Tested Devices
         if let devices = integration.testedDevices {
             for testedDevice in devices {
                 if let device = moc.device(withIdentifier: testedDevice.identifier) {
                     self.testedDevices?.insert(device)
                     continue
                 }
                 
                 let device = Device(context: moc)
                 device.identifier = testedDevice.identifier
                 device.update(withDevice: testedDevice)
                 self.testedDevices?.insert(device)
             }
         }
         
         // Revision Blueprint
         if let blueprint = integration.revisionBlueprint {
             for id in blueprint.repositoryIds {
                 if let repository = moc.repository(withIdentifier: id) {
                     repository.update(withRevisionBlueprint: blueprint, integration: self)
                     continue
                 }
                 
                 let repository = Repository(context: moc)
                 repository.identifier = id
                 repository.update(withRevisionBlueprint: blueprint, integration: self)
             }
         }
         
         return events
     }
 }
 */

#endif
