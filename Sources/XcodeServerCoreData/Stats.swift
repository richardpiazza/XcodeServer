import Foundation
import CoreData
import XcodeServerCommon
import XcodeServerAPI

public class Stats: NSManagedObject {
    
    public convenience init?(managedObjectContext: NSManagedObjectContext, bot: Bot) {
        self.init(managedObjectContext: managedObjectContext)
        self.bot = bot
    }
    
    public func update(withStats stats: XCSStats) {
        guard let moc = self.managedObjectContext else {
            return
        }
        
        self.numberOfIntegrations = stats.numberOfIntegrations as NSNumber?
        self.numberOfCommits = stats.numberOfCommits as NSNumber?
        self.numberOfSuccessfulIntegrations = stats.numberOfSuccessfulIntegrations as NSNumber?
        self.testAdditionRate = stats.testAdditionRate as NSNumber?
        self.codeCoveragePercentageDelta = stats.codeCoveragePercentageDelta as NSNumber?
        if let date = stats.sinceDate {
            self.sinceDate = dateFormatter.string(from: date)
        }
        
        if let statsLastCleanIntegrationIdentifier = stats.lastCleanIntegration?.integrationID {
            self.lastCleanIntegration = moc.integration(withIdentifier: statsLastCleanIntegrationIdentifier)
        }
        
        if let statsBestSuccessStreakIdentifier = stats.bestSuccessStreak?.integrationID {
            self.bestSuccessStreak = moc.integration(withIdentifier: statsBestSuccessStreakIdentifier)
        }
        
        if let statsBreakdown = stats.averageIntegrationTime {
            if self.averageIntegrationTime == nil {
                self.averageIntegrationTime = StatsBreakdown(managedObjectContext: moc)
                self.averageIntegrationTime?.inverseAverageIntegrationTime = self
            }
            
            self.averageIntegrationTime?.update(withStatsBreakdown: statsBreakdown)
        }
        
        if let statsBreakdown = stats.analysisWarnings {
            if self.analysisWarnings == nil {
                self.analysisWarnings = StatsBreakdown(managedObjectContext: moc)
                self.analysisWarnings?.inverseAnalysisWarnings = self
            }
            
            self.analysisWarnings?.update(withStatsBreakdown: statsBreakdown)
        }
        
        if let statsBreakdown = stats.testFailures {
            if self.testFailures == nil {
                self.testFailures = StatsBreakdown(managedObjectContext: moc)
                self.testFailures?.inverseTestFailures = self
            }
            
            self.testFailures?.update(withStatsBreakdown: statsBreakdown)
        }
        
        if let statsBreakdown = stats.errors {
            if self.errors == nil {
                self.errors = StatsBreakdown(managedObjectContext: moc)
                self.errors?.inverseErrors = self
            }
            
            self.errors?.update(withStatsBreakdown: statsBreakdown)
        }
        
        if let statsBreakdown = stats.regressedPerfTests {
            if self.regressedPerfTests == nil {
                self.regressedPerfTests = StatsBreakdown(managedObjectContext: moc)
                self.regressedPerfTests?.inverseRegressedPerfTests = self
            }
            
            self.regressedPerfTests?.update(withStatsBreakdown: statsBreakdown)
        }
        
        if let statsBreakdown = stats.warnings {
            if self.warnings == nil {
                self.warnings = StatsBreakdown(managedObjectContext: moc)
                self.warnings?.inverseWarnings = self
            }
            
            self.warnings?.update(withStatsBreakdown: statsBreakdown)
        }
        
        if let statsBreakdown = stats.improvedPerfTests {
            if self.improvedPerfTests == nil {
                self.improvedPerfTests = StatsBreakdown(managedObjectContext: moc)
                self.improvedPerfTests?.inverseImprovedPerfTests = self
            }
            
            self.improvedPerfTests?.update(withStatsBreakdown: statsBreakdown)
        }
        
        if let statsBreakdown = stats.tests {
            if self.tests == nil {
                self.tests = StatsBreakdown(managedObjectContext: moc)
                self.tests?.inverseTests = self
            }
            
            self.tests?.update(withStatsBreakdown: statsBreakdown)
        }
    }
}
