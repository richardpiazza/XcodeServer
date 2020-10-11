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
#endif
