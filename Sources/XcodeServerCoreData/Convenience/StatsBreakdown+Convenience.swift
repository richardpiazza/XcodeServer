import XcodeServer
#if canImport(CoreData)
import CoreData

public extension XcodeServerCoreData.StatsBreakdown {
   func update(_ analysis: XcodeServer.Bot.Stats.Analysis) {
        avg = analysis.average
        count = Int32(analysis.count)
        max = analysis.max
        min = analysis.min
        stdDev = analysis.standardDeviation
        sum = analysis.sum
    }
}

/*
 extension XcodeServerCoreData.StatsBreakdown {
     public func update(withStatsBreakdown breakdown: XCSStatsSummary) {
         self.sum = breakdown.sum
         self.count = Int32(breakdown.count)
         self.min = breakdown.min
         self.max = breakdown.max
         self.avg = breakdown.avg
         self.stdDev = breakdown.stdDev
     }
 }
 */

#endif
