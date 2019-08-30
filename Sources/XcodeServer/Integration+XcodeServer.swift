import Foundation
import XcodeServerCommon
import XcodeServerAPI
import XcodeServerCoreData

public extension Integration {
    func update(withIntegration integration: XCSIntegration) {
        guard let moc = self.managedObjectContext else {
            return
        }
        
        self.revision = integration._rev
        self.number = integration.number as NSNumber?
        self.shouldClean = integration.shouldClean as NSNumber?
        self.currentStep = integration.currentStep.rawValue
        self.result = integration.result.rawValue
        self.queuedDate = integration.queuedDate
        self.startedTime = integration.startedTime
        self.endedTime = integration.endedTime
        self.duration = integration.duration as NSNumber?
        self.successStreak = integration.successStreak as NSNumber?
        if let value = integration.testHierarchy {
            do {
                self.testHierachyData = try jsonEncoder.encode(value)
            } catch {
                print(error)
            }
        }
        
        // Build Results Summary
        if let summary = integration.buildResultSummary {
            self.buildResultSummary?.update(withBuildResultSummary: summary)
        }
        
        // Assets
        if let assets = integration.assets {
            self.assets?.update(withIntegrationAssets: assets)
        }
        
        // Tested Devices
        if let devices = integration.testedDevices {
            for testedDevice in devices {
                guard let identifier = testedDevice.identifier else {
                    continue
                }
                
                if let device = moc.device(withIdentifier: identifier) {
                    self.testedDevices?.insert(device)
                    continue
                }
                
                if let device = Device(managedObjectContext: moc, identifier: identifier) {
                    device.update(withDevice: testedDevice)
                    self.testedDevices?.insert(device)
                }
            }
        }
        
        // Revision Blueprint
        if let blueprint = integration.revisionBlueprint {
            for id in blueprint.repositoryIds {
                if let repository = moc.repository(withIdentifier: id) {
                    repository.update(withRevisionBlueprint: blueprint, integration: self)
                    continue
                }
                
                if let repository = Repository(managedObjectContext: moc, identifier: id) {
                    repository.update(withRevisionBlueprint: blueprint, integration: self)
                }
            }
        }
    }
    
    var testResults: [TestResult] {
        guard let data = self.testHierachyData else {
            return []
        }
        
        let testHierachy: XCSTestHierarchy
        do {
            testHierachy = try jsonDecoder.decode(XCSTestHierarchy.self, from: data)
        } catch {
            print(error)
            return []
        }
        
        guard testHierachy.suites.count > 0 else {
            return []
        }
        
        var results = [TestResult]()
        
        for suite in testHierachy.suites {
            for `class` in suite.classes {
                for method in `class`.methods {
                    results.append(TestResult(name: method.name.xcServerTestMethodName, passed: !method.hasFailures))
                }
            }
        }
        
        return results
    }
}
