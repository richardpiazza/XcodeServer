import Foundation
import CoreData

public extension Integration {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Integration> {
        return NSFetchRequest<Integration>(entityName: "Integration")
    }
    
    @NSManaged public var currentStep: String?
    @NSManaged public var duration: NSNumber?
    @NSManaged public var endedTime: Date?
    @NSManaged public var hasRetrievedAssets: NSNumber?
    @NSManaged public var hasRetrievedCommits: NSNumber?
    @NSManaged public var hasRetrievedIssues: NSNumber?
    @NSManaged public var identifier: String
    @NSManaged public var lastUpdate: Date?
    @NSManaged public var number: NSNumber?
    @NSManaged public var queuedDate: Date?
    @NSManaged public var result: String?
    @NSManaged public var shouldClean: NSNumber?
    @NSManaged public var startedTime: Date?
    @NSManaged public var successStreak: NSNumber?
    @NSManaged public var testHierachy: NSObject?
    @NSManaged public var testHierachyData: Data?
    @NSManaged public var revision: String?
    @NSManaged public var assets: IntegrationAssets?
    @NSManaged public var bot: Bot?
    @NSManaged public var buildResultSummary: BuildResultSummary?
    @NSManaged public var inverseBestSuccessStreak: Stats?
    @NSManaged public var inverseLastCleanIntegration: Stats?
    @NSManaged public var issues: IntegrationIssues?
    @NSManaged public var revisionBlueprints: Set<RevisionBlueprint>?
    @NSManaged public var testedDevices: Set<Device>?
    
}

// MARK: Generated accessors for revisionBlueprints
extension Integration {
    
    @objc(addRevisionBlueprintsObject:)
    @NSManaged public func addToRevisionBlueprints(_ value: RevisionBlueprint)
    
    @objc(removeRevisionBlueprintsObject:)
    @NSManaged public func removeFromRevisionBlueprints(_ value: RevisionBlueprint)
    
    @objc(addRevisionBlueprints:)
    @NSManaged public func addToRevisionBlueprints(_ values: Set<RevisionBlueprint>)
    
    @objc(removeRevisionBlueprints:)
    @NSManaged public func removeFromRevisionBlueprints(_ values: Set<RevisionBlueprint>)
    
}

// MARK: Generated accessors for testedDevices
extension Integration {
    
    @objc(addTestedDevicesObject:)
    @NSManaged public func addToTestedDevices(_ value: Device)
    
    @objc(removeTestedDevicesObject:)
    @NSManaged public func removeFromTestedDevices(_ value: Device)
    
    @objc(addTestedDevices:)
    @NSManaged public func addToTestedDevices(_ values: Set<Device>)
    
    @objc(removeTestedDevices:)
    @NSManaged public func removeFromTestedDevices(_ values: Set<Device>)
    
}
