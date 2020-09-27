import Foundation
#if canImport(CoreData)
import CoreData

@objc(Integration)
public class Integration: NSManagedObject {
    
    @NSManaged public var assets: IntegrationAssets?
    @NSManaged public var bot: Bot?
    @NSManaged public var buildResultSummary: BuildResultSummary?
    @NSManaged public var currentStepRawValue: String?
    @NSManaged public var duration: Double
    @NSManaged public var endedTime: Date?
    @NSManaged public var hasRetrievedAssets: Bool
    @NSManaged public var hasRetrievedCommits: Bool
    @NSManaged public var hasRetrievedIssues: Bool
    @NSManaged public var identifier: String
    @NSManaged public var lastUpdate: Date?
    @NSManaged public var number: Int32
    @NSManaged public var queuedDate: Date?
    @NSManaged public var resultRawValue: String?
    @NSManaged public var revision: String?
    @NSManaged public var shouldClean: Bool
    @NSManaged public var startedTime: Date?
    @NSManaged public var successStreak: Int32
    @NSManaged public var testHierarchyData: Data?
    @NSManaged public var inverseBestSuccessStreak: Stats?
    @NSManaged public var inverseLastCleanIntegration: Stats?
    @NSManaged public var issues: IntegrationIssues?
    @NSManaged public var revisionBlueprints: Set<RevisionBlueprint>?
    @NSManaged public var testedDevices: Set<Device>?
    
    @objc(addRevisionBlueprintsObject:)
    @NSManaged public func addToRevisionBlueprints(_ value: RevisionBlueprint)
    
    @objc(removeRevisionBlueprintsObject:)
    @NSManaged public func removeFromRevisionBlueprints(_ value: RevisionBlueprint)
    
    @objc(addRevisionBlueprints:)
    @NSManaged public func addToRevisionBlueprints(_ values: Set<RevisionBlueprint>)
    
    @objc(removeRevisionBlueprints:)
    @NSManaged public func removeFromRevisionBlueprints(_ values: Set<RevisionBlueprint>)
    
    @objc(addTestedDevicesObject:)
    @NSManaged public func addToTestedDevices(_ value: Device)
    
    @objc(removeTestedDevicesObject:)
    @NSManaged public func removeFromTestedDevices(_ value: Device)
    
    @objc(addTestedDevices:)
    @NSManaged public func addToTestedDevices(_ values: Set<Device>)
    
    @objc(removeTestedDevices:)
    @NSManaged public func removeFromTestedDevices(_ values: Set<Device>)
    
}

#endif
