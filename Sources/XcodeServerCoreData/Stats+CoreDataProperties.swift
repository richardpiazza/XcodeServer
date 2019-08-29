import Foundation
import CoreData

public extension Stats {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Stats> {
        return NSFetchRequest<Stats>(entityName: "Stats")
    }
    
    @NSManaged public var codeCoveragePercentageDelta: NSNumber?
    @NSManaged public var numberOfCommits: NSNumber?
    @NSManaged public var numberOfIntegrations: NSNumber?
    @NSManaged public var sinceDate: String?
    @NSManaged public var testAdditionRate: NSNumber?
    @NSManaged public var numberOfSuccessfulIntegrations: NSNumber?
    @NSManaged public var analysisWarnings: StatsBreakdown?
    @NSManaged public var averageIntegrationTime: StatsBreakdown?
    @NSManaged public var bestSuccessStreak: Integration?
    @NSManaged public var bot: Bot?
    @NSManaged public var errors: StatsBreakdown?
    @NSManaged public var improvedPerfTests: StatsBreakdown?
    @NSManaged public var lastCleanIntegration: Integration?
    @NSManaged public var regressedPerfTests: StatsBreakdown?
    @NSManaged public var testFailures: StatsBreakdown?
    @NSManaged public var tests: StatsBreakdown?
    @NSManaged public var warnings: StatsBreakdown?
    
}
