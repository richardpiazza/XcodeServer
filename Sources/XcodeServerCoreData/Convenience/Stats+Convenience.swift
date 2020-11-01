import XcodeServer
#if canImport(CoreData)
import CoreData

public extension Stats {
    private static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return formatter
    }
    
    // 2019-08-05T22:44:32.724Z
    var since: Date {
        get {
            guard let string = sinceDate, !string.isEmpty else {
                return Date()
            }
            
            return Self.dateFormatter.date(from: string) ?? Date()
        }
        set {
            sinceDate = Self.dateFormatter.string(from: newValue)
        }
    }
}

public extension XcodeServerCoreData.Stats {
    func update(_ stats: XcodeServer.Bot.Stats, context: NSManagedObjectContext) {
        codeCoveragePercentageDelta = Int32(stats.coverageDelta)
        numberOfCommits = Int32(stats.commits)
        numberOfIntegrations = Int32(stats.integrations)
        numberOfSuccessfulIntegrations = Int32(stats.successfulIntegrations)
        since = stats.sinceDate
        testAdditionRate = Int32(stats.testAdditionRate)
        
        if let breakdown = analysisWarnings {
            breakdown.update(stats.analysisWarnings)
        } else {
            let new = StatsBreakdown(context: context)
            new.update(stats.analysisWarnings)
            analysisWarnings = new
        }
        
        if let breakdown = averageIntegrationTime {
            breakdown.update(stats.averageIntegrationTime)
        } else {
            let new = StatsBreakdown(context: context)
            new.update(stats.averageIntegrationTime)
            averageIntegrationTime = new
        }
        
        if let breakdown = errors {
            breakdown.update(stats.errors)
        } else {
            let new = StatsBreakdown(context: context)
            new.update(stats.errors)
            errors = new
        }
        
        if let breakdown = improvedPerfTests {
            breakdown.update(stats.improvedPerformanceTests)
        } else {
            let new = StatsBreakdown(context: context)
            new.update(stats.improvedPerformanceTests)
            improvedPerfTests = new
        }
        
        if let breakdown = regressedPerfTests {
            breakdown.update(stats.regressedPerformanceTests)
        } else {
            let new = StatsBreakdown(context: context)
            new.update(stats.regressedPerformanceTests)
            regressedPerfTests = new
        }
        
        if let breakdown = testFailures {
            breakdown.update(stats.testFailures)
        } else {
            let new = StatsBreakdown(context: context)
            new.update(stats.testFailures)
            testFailures = new
        }
        
        if let breakdown = tests {
            breakdown.update(stats.tests)
        } else {
            let new = StatsBreakdown(context: context)
            new.update(stats.tests)
            tests = new
        }
        
        if let breakdown = warnings {
            breakdown.update(stats.warnings)
        } else {
            let new = StatsBreakdown(context: context)
            new.update(stats.warnings)
            warnings = new
        }
    }
}
#endif
