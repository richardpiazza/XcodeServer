import Foundation
#if canImport(CoreData)
import CoreData

@objc(Stats)
public class Stats: NSManagedObject {

}

extension Stats {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Stats> {
        return NSFetchRequest<Stats>(entityName: "Stats")
    }

    @NSManaged public var codeCoveragePercentageDelta: Int32
    @NSManaged public var numberOfCommits: Int32
    @NSManaged public var numberOfIntegrations: Int32
    @NSManaged public var numberOfSuccessfulIntegrations: Int32
    @NSManaged public var sinceDate: String?
    @NSManaged public var testAdditionRate: Int32
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
#endif
