import Foundation
import XcodeServerCommon
import XcodeServerAPI
import XcodeServerCoreData

extension Configuration {
    public func update(withConfiguration configuration: XCSConfiguration) {
        guard let moc = self.managedObjectContext else {
            return
        }
        
        self.schemeName = configuration.schemeName
        
        self.builtFromClean = configuration.builtFromClean?.rawValue as NSNumber?
        self.disableAppThinning = configuration.disableAppThinning as NSNumber?
        self.codeCoveragePreference = configuration.codeCoveragePreference?.rawValue as NSNumber?
        self.useParallelDeviceTesting = configuration.useParallelDeviceTesting as NSNumber?
        self.performsArchiveAction = configuration.performsArchiveAction as NSNumber?
        self.performsAnalyzeAction = configuration.performsAnalyzeAction as NSNumber?
        self.exportsProductFromArchive = configuration.exportsProductFromArchive as NSNumber?
        
        self.performsTestAction = configuration.performsTestAction as NSNumber?
        self.runOnlyDisabledTests = configuration.runOnlyDisabledTests as NSNumber?
        self.testingDestinationType = configuration.testingDestinationType as NSNumber?
        // TODO: testLocalizations?
        
        self.scheduleType = configuration.scheduleType?.rawValue as NSNumber?
        self.periodicScheduleInterval = configuration.periodicScheduleInterval.rawValue as NSNumber?
        self.weeklyScheduleDay = configuration.weeklyScheduleDay as NSNumber?
        self.hourOfIntegration = configuration.hourOfIntegration as NSNumber?
        self.minutesAfterHourToIntegrate = configuration.minutesAfterHourToIntegrate as NSNumber?
        self.performsUpgradeIntegration = configuration.performsUpgradeIntegration as NSNumber?
        
        if let provConfig = configuration.provisioningConfiguration {
            self.addMissingDeviceToTeams = provConfig.addMissingDevicesToTeams as NSNumber
            self.manageCertsAndProfiles = provConfig.manageCertsAndProfiles as NSNumber
        }
        
        if #available(macOS 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *) {
            if let buildArgs = configuration.additionalBuildArguments {
                do {
                    self.additionalBuildArgumentsData = try jsonEncoder.encode(buildArgs)
                } catch {
                    
                }
            }
            
            if let envVars = configuration.buildEnvironmentVariables {
                do {
                    self.buildEnvironmentVariablesData = try jsonEncoder.encode(envVars)
                } catch {
                    
                }
            }
        }
        
        // Repositories
        if let configurationBlueprint = configuration.sourceControlBlueprint {
            if let repositories = self.repositories {
                for repository in repositories {
                    let _ = repository.configurations?.remove(self)
                }
            }
            
            if let remoteRepositories = configurationBlueprint.remoteRepositories {
                for remoteRepository in remoteRepositories {
                    guard let identifier = remoteRepository.identifier else {
                        continue
                    }
                    
                    var repo: Repository?
                    if let r = moc.repository(withIdentifier: identifier) {
                        repo = r
                    } else if let r = Repository(managedObjectContext: moc, identifier: identifier) {
                        repo = r
                    }
                    
                    guard let repository = repo else {
                        continue
                    }
                    
                    repository.update(withRevisionBlueprint: configurationBlueprint)
                    
                    if let repositories = self.repositories {
                        if !repositories.contains(repository) {
                            self.repositories?.insert(repository)
                        }
                    }
                }
            }
        }
        
        // Device Specification
        if let configurationDeviceSpecification = configuration.deviceSpecification {
            self.deviceSpecification?.update(withDeviceSpecification: configurationDeviceSpecification)
        }
        
        // Triggers
        if let triggers = self.triggers {
            for trigger in triggers {
                trigger.configuration = nil
                moc.delete(trigger)
            }
        }
        
        if let configTriggers = configuration.triggers {
            for configurationTrigger in configTriggers {
                if let trigger = Trigger(managedObjectContext: moc, configuration: self) {
                    trigger.update(withTrigger: configurationTrigger)
                }
            }
        }
    }
}
