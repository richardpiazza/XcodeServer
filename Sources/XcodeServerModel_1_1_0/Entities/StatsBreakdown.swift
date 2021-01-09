import XcodeServer
import XcodeServerCoreData
import Foundation
#if canImport(CoreData)
import CoreData

//@objc(StatsBreakdown)
public class StatsBreakdown: NSManagedObject {

}

extension StatsBreakdown {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StatsBreakdown> {
        return NSFetchRequest<StatsBreakdown>(entityName: "StatsBreakdown")
    }

    @NSManaged public var avg: Double
    @NSManaged public var count: Int32
    @NSManaged public var max: Double
    @NSManaged public var min: Double
    @NSManaged public var stdDev: Double
    @NSManaged public var sum: Double
    @NSManaged public var inverseAnalysisWarnings: Stats?
    @NSManaged public var inverseAverageIntegrationTime: Stats?
    @NSManaged public var inverseErrors: Stats?
    @NSManaged public var inverseImprovedPerfTests: Stats?
    @NSManaged public var inverseRegressedPerfTests: Stats?
    @NSManaged public var inverseTestFailures: Stats?
    @NSManaged public var inverseTests: Stats?
    @NSManaged public var inverseWarnings: Stats?

}

public extension StatsBreakdown {
   func update(_ analysis: XcodeServer.Bot.Stats.Analysis) {
        avg = analysis.average
        count = Int32(analysis.count)
        max = analysis.max
        min = analysis.min
        stdDev = analysis.standardDeviation
        sum = analysis.sum
    }
}

public extension XcodeServer.Bot.Stats.Analysis {
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
