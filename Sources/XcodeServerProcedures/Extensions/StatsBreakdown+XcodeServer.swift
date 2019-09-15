import Foundation
import XcodeServerAPI
#if canImport(CoreData)
import XcodeServerCoreData

extension StatsBreakdown {
    public func update(withStatsBreakdown breakdown: XCSStatsSummary) {
        self.sum = breakdown.sum
        self.count = Int32(breakdown.count)
        self.min = breakdown.min
        self.max = breakdown.max
        self.avg = breakdown.avg
        self.stdDev = breakdown.stdDev
    }
}

#endif
