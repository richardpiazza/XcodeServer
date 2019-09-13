import Foundation
#if canImport(CoreData)
import CoreData

@objc(StatsBreakdown)
public class StatsBreakdown: NSManagedObject {
    
    public convenience init?(into context: NSManagedObjectContext) {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: type(of: self).entityName, in: context) else {
            return nil
        }
        
        self.init(entity: entityDescription, insertInto: context)
        self.avg = 0.0
        self.count = 0
        self.max = 0.0
        self.min = 0.0
        self.stdDev = 0.0
        self.sum = 0.0
    }
}

// MARK: - CoreData Properties
public extension StatsBreakdown {
    
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

#endif
