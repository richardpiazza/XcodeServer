import Foundation
import CoreData

public extension Stats {
    
    @nonobjc class func fetchRequest() -> NSFetchRequest<Stats> {
        return NSFetchRequest<Stats>(entityName: "Stats")
    }
    
    @NSManaged var codeCoveragePercentageDelta: NSNumber?
    @NSManaged var numberOfCommits: NSNumber?
    @NSManaged var numberOfIntegrations: NSNumber?
    @NSManaged var sinceDate: String?
    @NSManaged var testAdditionRate: NSNumber?
    @NSManaged var numberOfSuccessfulIntegrations: NSNumber?
    @NSManaged var analysisWarnings: StatsBreakdown?
    @NSManaged var averageIntegrationTime: StatsBreakdown?
    @NSManaged var bestSuccessStreak: Integration?
    @NSManaged var bot: Bot?
    @NSManaged var errors: StatsBreakdown?
    @NSManaged var improvedPerfTests: StatsBreakdown?
    @NSManaged var lastCleanIntegration: Integration?
    @NSManaged var regressedPerfTests: StatsBreakdown?
    @NSManaged var testFailures: StatsBreakdown?
    @NSManaged var tests: StatsBreakdown?
    @NSManaged var warnings: StatsBreakdown?
    
}
