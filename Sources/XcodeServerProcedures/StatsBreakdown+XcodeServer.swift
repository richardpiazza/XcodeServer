import Foundation
import XcodeServerAPI
import XcodeServerCoreData

extension StatsBreakdown {
    public func update(withStatsBreakdown breakdown: XCSStatsSummary) {
        self.sum = breakdown.sum as NSNumber?
        self.count = breakdown.count as NSNumber?
        self.min = breakdown.min as NSNumber?
        self.max = breakdown.max as NSNumber?
        self.avg = breakdown.avg as NSNumber?
        self.stdDev = breakdown.stdDev as NSNumber?
    }
}