import Foundation
#if canImport(CoreData)
import CoreData

@objc(StatsBreakdown)
public class StatsBreakdown: NSManagedObject {
    
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

#endif
