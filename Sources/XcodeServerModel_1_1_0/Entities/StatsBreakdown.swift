import XcodeServer
import CoreDataPlus
import Foundation
#if canImport(CoreData)
import CoreData

//@objc(StatsBreakdown)
class StatsBreakdown: NSManagedObject {

}

extension StatsBreakdown {

    @nonobjc class func fetchRequest() -> NSFetchRequest<StatsBreakdown> {
        return NSFetchRequest<StatsBreakdown>(entityName: "StatsBreakdown")
    }

    @NSManaged var avg: Double
    @NSManaged var count: Int32
    @NSManaged var max: Double
    @NSManaged var min: Double
    @NSManaged var stdDev: Double
    @NSManaged var sum: Double
    @NSManaged var inverseAnalysisWarnings: Stats?
    @NSManaged var inverseAverageIntegrationTime: Stats?
    @NSManaged var inverseErrors: Stats?
    @NSManaged var inverseImprovedPerfTests: Stats?
    @NSManaged var inverseRegressedPerfTests: Stats?
    @NSManaged var inverseTestFailures: Stats?
    @NSManaged var inverseTests: Stats?
    @NSManaged var inverseWarnings: Stats?

}

extension StatsBreakdown {
   func update(_ analysis: XcodeServer.Bot.Stats.Analysis) {
        avg = analysis.average
        count = Int32(analysis.count)
        max = analysis.max
        min = analysis.min
        stdDev = analysis.standardDeviation
        sum = analysis.sum
    }
}

extension XcodeServer.Bot.Stats.Analysis {
    init(_ breakdown: StatsBreakdown) {
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
