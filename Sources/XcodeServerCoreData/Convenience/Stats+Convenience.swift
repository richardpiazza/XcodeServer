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
        
        if let integration = stats.bestSuccessStreak, bestSuccessStreak == nil {
            if let existing = context.integration(withIdentifier: integration.id) {
                bestSuccessStreak = existing
            } else {
                let new = Integration(context: context)
                new.update(integration, context: context)
                bestSuccessStreak = new
            }
        }
        
        if let integration = stats.lastCleanIntegration, lastCleanIntegration == nil {
            if let existing = context.integration(withIdentifier: integration.id) {
                lastCleanIntegration = existing
            } else {
                let new = Integration(context: context)
                new.update(integration, context: context)
                lastCleanIntegration = new
            }
        }
    }
}

/*
 extension XcodeServerCoreData.Stats {
     private static var dateFormatter: DateFormatter = {
         let formatter = DateFormatter()
         formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
         return formatter
     }()
     
     public func update(withStats stats: XCSStats) {
         guard let moc = self.managedObjectContext else {
             return
         }
         
         self.numberOfIntegrations = Int32(stats.numberOfIntegrations ?? 0)
         self.numberOfCommits = Int32(stats.numberOfCommits ?? 0)
         self.numberOfSuccessfulIntegrations = Int32(stats.numberOfSuccessfulIntegrations ?? 0)
         self.testAdditionRate = Int32(stats.testAdditionRate ?? 0)
         self.codeCoveragePercentageDelta = Int32(stats.codeCoveragePercentageDelta ?? 0)
         if let date = stats.sinceDate {
             self.sinceDate = Self.dateFormatter.string(from: date)
         }
         
         if let statsLastCleanIntegrationIdentifier = stats.lastCleanIntegration?.integrationID {
             self.lastCleanIntegration = moc.integration(withIdentifier: statsLastCleanIntegrationIdentifier)
         }
         
         if let statsBestSuccessStreakIdentifier = stats.bestSuccessStreak?.integrationID {
             self.bestSuccessStreak = moc.integration(withIdentifier: statsBestSuccessStreakIdentifier)
         }
         
         if let statsBreakdown = stats.averageIntegrationTime {
             if self.averageIntegrationTime == nil {
                 self.averageIntegrationTime = StatsBreakdown(context: moc)
                 self.averageIntegrationTime?.inverseAverageIntegrationTime = self
             }
             
             self.averageIntegrationTime?.update(withStatsBreakdown: statsBreakdown)
         }
         
         if let statsBreakdown = stats.analysisWarnings {
             if self.analysisWarnings == nil {
                 self.analysisWarnings = StatsBreakdown(context: moc)
                 self.analysisWarnings?.inverseAnalysisWarnings = self
             }
             
             self.analysisWarnings?.update(withStatsBreakdown: statsBreakdown)
         }
         
         if let statsBreakdown = stats.testFailures {
             if self.testFailures == nil {
                 self.testFailures = StatsBreakdown(context: moc)
                 self.testFailures?.inverseTestFailures = self
             }
             
             self.testFailures?.update(withStatsBreakdown: statsBreakdown)
         }
         
         if let statsBreakdown = stats.errors {
             if self.errors == nil {
                 self.errors = StatsBreakdown(context: moc)
                 self.errors?.inverseErrors = self
             }
             
             self.errors?.update(withStatsBreakdown: statsBreakdown)
         }
         
         if let statsBreakdown = stats.regressedPerfTests {
             if self.regressedPerfTests == nil {
                 self.regressedPerfTests = StatsBreakdown(context: moc)
                 self.regressedPerfTests?.inverseRegressedPerfTests = self
             }
             
             self.regressedPerfTests?.update(withStatsBreakdown: statsBreakdown)
         }
         
         if let statsBreakdown = stats.warnings {
             if self.warnings == nil {
                 self.warnings = StatsBreakdown(context: moc)
                 self.warnings?.inverseWarnings = self
             }
             
             self.warnings?.update(withStatsBreakdown: statsBreakdown)
         }
         
         if let statsBreakdown = stats.improvedPerfTests {
             if self.improvedPerfTests == nil {
                 self.improvedPerfTests = StatsBreakdown(context: moc)
                 self.improvedPerfTests?.inverseImprovedPerfTests = self
             }
             
             self.improvedPerfTests?.update(withStatsBreakdown: statsBreakdown)
         }
         
         if let statsBreakdown = stats.tests {
             if self.tests == nil {
                 self.tests = StatsBreakdown(context: moc)
                 self.tests?.inverseTests = self
             }
             
             self.tests?.update(withStatsBreakdown: statsBreakdown)
         }
     }
 }
 */

#endif
