import Foundation
import XcodeServerCommon
import XcodeServerAPI
import XcodeServerCoreData

extension Stats {
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
            self.sinceDate = JSON.dateFormatter.string(from: date)
        }
        
        if let statsLastCleanIntegrationIdentifier = stats.lastCleanIntegration?.integrationID {
            self.lastCleanIntegration = moc.integration(withIdentifier: statsLastCleanIntegrationIdentifier)
        }
        
        if let statsBestSuccessStreakIdentifier = stats.bestSuccessStreak?.integrationID {
            self.bestSuccessStreak = moc.integration(withIdentifier: statsBestSuccessStreakIdentifier)
        }
        
        if let statsBreakdown = stats.averageIntegrationTime {
            if self.averageIntegrationTime == nil {
                self.averageIntegrationTime = StatsBreakdown(into: moc)
                self.averageIntegrationTime?.inverseAverageIntegrationTime = self
            }
            
            self.averageIntegrationTime?.update(withStatsBreakdown: statsBreakdown)
        }
        
        if let statsBreakdown = stats.analysisWarnings {
            if self.analysisWarnings == nil {
                self.analysisWarnings = StatsBreakdown(into: moc)
                self.analysisWarnings?.inverseAnalysisWarnings = self
            }
            
            self.analysisWarnings?.update(withStatsBreakdown: statsBreakdown)
        }
        
        if let statsBreakdown = stats.testFailures {
            if self.testFailures == nil {
                self.testFailures = StatsBreakdown(into: moc)
                self.testFailures?.inverseTestFailures = self
            }
            
            self.testFailures?.update(withStatsBreakdown: statsBreakdown)
        }
        
        if let statsBreakdown = stats.errors {
            if self.errors == nil {
                self.errors = StatsBreakdown(into: moc)
                self.errors?.inverseErrors = self
            }
            
            self.errors?.update(withStatsBreakdown: statsBreakdown)
        }
        
        if let statsBreakdown = stats.regressedPerfTests {
            if self.regressedPerfTests == nil {
                self.regressedPerfTests = StatsBreakdown(into: moc)
                self.regressedPerfTests?.inverseRegressedPerfTests = self
            }
            
            self.regressedPerfTests?.update(withStatsBreakdown: statsBreakdown)
        }
        
        if let statsBreakdown = stats.warnings {
            if self.warnings == nil {
                self.warnings = StatsBreakdown(into: moc)
                self.warnings?.inverseWarnings = self
            }
            
            self.warnings?.update(withStatsBreakdown: statsBreakdown)
        }
        
        if let statsBreakdown = stats.improvedPerfTests {
            if self.improvedPerfTests == nil {
                self.improvedPerfTests = StatsBreakdown(into: moc)
                self.improvedPerfTests?.inverseImprovedPerfTests = self
            }
            
            self.improvedPerfTests?.update(withStatsBreakdown: statsBreakdown)
        }
        
        if let statsBreakdown = stats.tests {
            if self.tests == nil {
                self.tests = StatsBreakdown(into: moc)
                self.tests?.inverseTests = self
            }
            
            self.tests?.update(withStatsBreakdown: statsBreakdown)
        }
    }
}
