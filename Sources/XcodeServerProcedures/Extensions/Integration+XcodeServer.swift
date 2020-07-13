import Foundation
import XcodeServerCommon
import XcodeServerAPI
#if canImport(CoreData)
import XcodeServerCoreData

public extension Integration {
    @discardableResult
    func update(withIntegration integration: XCSIntegration) -> [XcodeServerProcedureEvent] {
        var events: [XcodeServerProcedureEvent] = []
        
        guard let moc = self.managedObjectContext else {
            return events
        }
        
        if (currentStep != integration.currentStep) || (result != integration.result) {
            events.append(.integration(action: .update, identifier: integration.id, number: integration.number))
        }
        
        self.currentStep = integration.currentStep
        self.duration = integration.duration ?? 0.0
        self.endedTime = integration.endedTime
        self.number = integration.number
        self.queuedDate = integration.queuedDate
        self.result = integration.result
        self.shouldClean = integration.shouldClean ?? false
        self.startedTime = integration.startedTime
        self.successStreak = integration.successStreak ?? 0
        
        if let value = integration.testHierarchy {
            do {
                self.testHierarchyData = try JSON.jsonEncoder.encode(value)
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
                if let device = moc.device(withIdentifier: testedDevice.identifier) {
                    self.testedDevices?.insert(device)
                    continue
                }
                
                if let device = Device(managedObjectContext: moc, identifier: testedDevice.identifier) {
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
        
        return events
    }
}

#endif
