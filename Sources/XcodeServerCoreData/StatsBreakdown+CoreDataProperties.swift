import Foundation
import CoreData

public extension StatsBreakdown {

    @NSManaged var avg: NSNumber?
    @NSManaged var count: NSNumber?
    @NSManaged var max: NSNumber?
    @NSManaged var min: NSNumber?
    @NSManaged var stdDev: NSNumber?
    @NSManaged var sum: NSNumber?
    @NSManaged var inverseAnalysisWarnings: Stats?
    @NSManaged var inverseAverageIntegrationTime: Stats?
    @NSManaged var inverseErrors: Stats?
    @NSManaged var inverseImprovedPerfTests: Stats?
    @NSManaged var inverseRegressedPerfTests: Stats?
    @NSManaged var inverseTestFailures: Stats?
    @NSManaged var inverseTests: Stats?
    @NSManaged var inverseWarnings: Stats?

}
