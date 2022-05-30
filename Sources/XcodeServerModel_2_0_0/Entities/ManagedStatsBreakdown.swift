import Foundation
import CoreDataPlus
import XcodeServer
#if canImport(CoreData)
import CoreData

public class ManagedStatsBreakdown: NSManagedObject {

}

extension ManagedStatsBreakdown {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedStatsBreakdown> {
        return NSFetchRequest<ManagedStatsBreakdown>(entityName: "ManagedStatsBreakdown")
    }

    @NSManaged public var avg: Double
    @NSManaged public var count: Int32
    @NSManaged public var max: Double
    @NSManaged public var min: Double
    @NSManaged public var stdDev: Double
    @NSManaged public var sum: Double
    @NSManaged public var inverseAnalysisWarnings: ManagedStats?
    @NSManaged public var inverseAverageIntegrationTime: ManagedStats?
    @NSManaged public var inverseErrors: ManagedStats?
    @NSManaged public var inverseImprovedPerfTests: ManagedStats?
    @NSManaged public var inverseRegressedPerfTests: ManagedStats?
    @NSManaged public var inverseTestFailures: ManagedStats?
    @NSManaged public var inverseTests: ManagedStats?
    @NSManaged public var inverseWarnings: ManagedStats?

}

extension ManagedStatsBreakdown {
   func update(_ analysis: Bot.Stats.Analysis) {
        avg = analysis.average
        count = Int32(analysis.count)
        max = analysis.max
        min = analysis.min
        stdDev = analysis.standardDeviation
        sum = analysis.sum
    }
}

extension Bot.Stats.Analysis {
    init(_ breakdown: ManagedStatsBreakdown) {
        self.init()
        count = Int(breakdown.count)
        sum = breakdown.sum
        min = breakdown.min
        max = breakdown.max
        average = breakdown.avg
        standardDeviation = breakdown.stdDev
    }
}
#endif
