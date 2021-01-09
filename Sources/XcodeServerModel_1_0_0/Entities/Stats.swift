import XcodeServer
import XcodeServerCoreData
import Foundation
#if canImport(CoreData)
import CoreData

//@objc(Stats)
public class Stats: NSManagedObject {

}

extension Stats {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Stats> {
        return NSFetchRequest<Stats>(entityName: "Stats")
    }

    @NSManaged public var codeCoveragePercentageDelta: Int32
    @NSManaged public var numberOfCommits: Int32
    @NSManaged public var numberOfIntegrations: Int32
    @NSManaged public var numberOfSuccessfulIntegrations: Int32
    @NSManaged public var sinceDate: String?
    @NSManaged public var testAdditionRate: Int32
    @NSManaged public var analysisWarnings: StatsBreakdown?
    @NSManaged public var averageIntegrationTime: StatsBreakdown?
    @NSManaged public var bestSuccessStreak: Integration?
    @NSManaged public var bot: Bot?
    @NSManaged public var errors: StatsBreakdown?
    @NSManaged public var improvedPerfTests: StatsBreakdown?
    @NSManaged public var lastCleanIntegration: Integration?
    @NSManaged public var regressedPerfTests: StatsBreakdown?
    @NSManaged public var testFailures: StatsBreakdown?
    @NSManaged public var tests: StatsBreakdown?
    @NSManaged public var warnings: StatsBreakdown?

}

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

public extension Stats {
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
            let new: StatsBreakdown = context.make()
            new.update(stats.analysisWarnings)
            analysisWarnings = new
        }
        
        if let breakdown = averageIntegrationTime {
            breakdown.update(stats.averageIntegrationTime)
        } else {
            let new: StatsBreakdown = context.make()
            new.update(stats.averageIntegrationTime)
            averageIntegrationTime = new
        }
        
        if let breakdown = errors {
            breakdown.update(stats.errors)
        } else {
            let new: StatsBreakdown = context.make()
            new.update(stats.errors)
            errors = new
        }
        
        if let breakdown = improvedPerfTests {
            breakdown.update(stats.improvedPerformanceTests)
        } else {
            let new: StatsBreakdown = context.make()
            new.update(stats.improvedPerformanceTests)
            improvedPerfTests = new
        }
        
        if let breakdown = regressedPerfTests {
            breakdown.update(stats.regressedPerformanceTests)
        } else {
            let new: StatsBreakdown = context.make()
            new.update(stats.regressedPerformanceTests)
            regressedPerfTests = new
        }
        
        if let breakdown = testFailures {
            breakdown.update(stats.testFailures)
        } else {
            let new: StatsBreakdown = context.make()
            new.update(stats.testFailures)
            testFailures = new
        }
        
        if let breakdown = tests {
            breakdown.update(stats.tests)
        } else {
            let new: StatsBreakdown = context.make()
            new.update(stats.tests)
            tests = new
        }
        
        if let breakdown = warnings {
            breakdown.update(stats.warnings)
        } else {
            let new: StatsBreakdown = context.make()
            new.update(stats.warnings)
            warnings = new
        }
        
        if let integration = stats.bestSuccessStreak, bestSuccessStreak == nil {
            if let existing = Integration.integration(integration.id, in: context) {
                bestSuccessStreak = existing
            } else {
                let new: Integration = context.make()
                new.update(integration, context: context)
                bestSuccessStreak = new
            }
        }
        
        if let integration = stats.lastCleanIntegration, lastCleanIntegration == nil {
            if let existing = Integration.integration(integration.id, in: context) {
                lastCleanIntegration = existing
            } else {
                let new: Integration = context.make()
                new.update(integration, context: context)
                lastCleanIntegration = new
            }
        }
    }
}

public extension XcodeServer.Bot.Stats {
    init(_ stats: Stats) {
        self.init()
        commits = Int(stats.numberOfCommits)
        integrations = Int(stats.numberOfIntegrations)
        successfulIntegrations = Int(stats.numberOfSuccessfulIntegrations)
        coverageDelta = Int(stats.codeCoveragePercentageDelta)
        testAdditionRate = Int(stats.testAdditionRate)
        sinceDate = stats.since
        if let breakdown = stats.analysisWarnings {
            analysisWarnings = Analysis(breakdown)
        }
        if let breakdown = stats.averageIntegrationTime {
            averageIntegrationTime = Analysis(breakdown)
        }
        if let breakdown = stats.errors {
            errors = Analysis(breakdown)
        }
        if let breakdown = stats.improvedPerfTests {
            improvedPerformanceTests = Analysis(breakdown)
        }
        if let breakdown = stats.regressedPerfTests {
            regressedPerformanceTests = Analysis(breakdown)
        }
        if let breakdown = stats.testFailures {
            testFailures = Analysis(breakdown)
        }
        if let breakdown = stats.tests {
            tests = Analysis(breakdown)
        }
        if let breakdown = stats.warnings {
            warnings = Analysis(breakdown)
        }
        if let integration = stats.bestSuccessStreak {
            bestSuccessStreak = XcodeServer.Integration(integration)
        }
        if let integration = stats.lastCleanIntegration {
            lastCleanIntegration = XcodeServer.Integration(integration)
        }
    }
}
#endif
