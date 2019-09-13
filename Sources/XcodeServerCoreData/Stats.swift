import Foundation
#if canImport(CoreData)
import CoreData

@objc(Stats)
public class Stats: NSManagedObject {
    
    public convenience init?(managedObjectContext: NSManagedObjectContext, bot: Bot) {
        self.init(managedObjectContext: managedObjectContext)
        self.bot = bot
        self.codeCoveragePercentageDelta = 0
        self.numberOfCommits = 0
        self.numberOfIntegrations = 0
        self.testAdditionRate = 0
        self.numberOfSuccessfulIntegrations = 0
    }
}

// MARK: - CoreData Properties
public extension Stats {
    
    @nonobjc class func fetchRequest() -> NSFetchRequest<Stats> {
        return NSFetchRequest<Stats>(entityName: entityName)
    }
    
    @NSManaged var codeCoveragePercentageDelta: Int32
    @NSManaged var numberOfCommits: Int32
    @NSManaged var numberOfIntegrations: Int32
    @NSManaged var sinceDate: String?
    @NSManaged var testAdditionRate: Int32
    @NSManaged var numberOfSuccessfulIntegrations: Int32
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

#endif
