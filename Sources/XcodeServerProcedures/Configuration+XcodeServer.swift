import Foundation
import XcodeServerCommon
import XcodeServerAPI
#if canImport(CoreData)
import XcodeServerCoreData

extension Configuration {
    public func update(withConfiguration configuration: XCSConfiguration) {
        guard let moc = self.managedObjectContext else {
            return
        }
        
        self.schemeName = configuration.schemeName
        
        self.cleanSchedule = configuration.builtFromClean ?? .never
        self.disableAppThinning = configuration.disableAppThinning ?? false
        self.codeCoveragePreference = configuration.codeCoveragePreference ?? .disabled
        self.useParallelDeviceTesting = configuration.useParallelDeviceTesting ?? false
        self.performsArchiveAction = configuration.performsArchiveAction ?? false
        self.performsAnalyzeAction = configuration.performsAnalyzeAction ?? false
        self.exportsProductFromArchive = configuration.exportsProductFromArchive ?? false
        self.performsTestAction = configuration.performsTestAction ?? false
        self.runOnlyDisabledTests = configuration.runOnlyDisabledTests ?? false
        self.testingDestinationTypeRawValue = Int16(configuration.testingDestinationType ?? 0)
        
        
        self.scheduleType = configuration.scheduleType ?? .periodic
        self.periodicScheduleInterval = configuration.periodicScheduleInterval
        self.weeklyScheduleDay = Int16(configuration.weeklyScheduleDay ?? 0)
        self.hourOfIntegration = Int16(configuration.hourOfIntegration ?? 0)
        self.minutesAfterHourToIntegrate = Int16(configuration.minutesAfterHourToIntegrate ?? 0)
        self.performsUpgradeIntegration = configuration.performsUpgradeIntegration ?? false
        self.addMissingDeviceToTeams = configuration.provisioningConfiguration?.addMissingDevicesToTeams ?? false
        self.manageCertsAndProfiles = configuration.provisioningConfiguration?.manageCertsAndProfiles ?? false
        
        if #available(macOS 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *) {
            if let buildArgs = configuration.additionalBuildArguments {
                do {
                    self.additionalBuildArgumentsData = try JSON.jsonEncoder.encode(buildArgs)
                } catch {
                    
                }
            }
            
            if let envVars = configuration.buildEnvironmentVariables {
                do {
                    self.buildEnvironmentVariablesData = try JSON.jsonEncoder.encode(envVars)
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

#endif
