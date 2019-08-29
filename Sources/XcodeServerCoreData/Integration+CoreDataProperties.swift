import Foundation
import CoreData

public extension Integration {
    
    @nonobjc class func fetchRequest() -> NSFetchRequest<Integration> {
        return NSFetchRequest<Integration>(entityName: "Integration")
    }
    
    @NSManaged var currentStep: String?
    @NSManaged var duration: NSNumber?
    @NSManaged var endedTime: Date?
    @NSManaged var hasRetrievedAssets: NSNumber?
    @NSManaged var hasRetrievedCommits: NSNumber?
    @NSManaged var hasRetrievedIssues: NSNumber?
    @NSManaged var identifier: String
    @NSManaged var lastUpdate: Date?
    @NSManaged var number: NSNumber?
    @NSManaged var queuedDate: Date?
    @NSManaged var result: String?
    @NSManaged var shouldClean: NSNumber?
    @NSManaged var startedTime: Date?
    @NSManaged var successStreak: NSNumber?
    @NSManaged var testHierachy: NSObject?
    @NSManaged var testHierachyData: Data?
    @NSManaged var revision: String?
    @NSManaged var assets: IntegrationAssets?
    @NSManaged var bot: Bot?
    @NSManaged var buildResultSummary: BuildResultSummary?
    @NSManaged var inverseBestSuccessStreak: Stats?
    @NSManaged var inverseLastCleanIntegration: Stats?
    @NSManaged var issues: IntegrationIssues?
    @NSManaged var revisionBlueprints: Set<RevisionBlueprint>?
    @NSManaged var testedDevices: Set<Device>?
    
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
