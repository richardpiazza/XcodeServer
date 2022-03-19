import Foundation

public extension Bot {
    
    struct Stats: Hashable, Codable {
        
        public struct Analysis: Hashable, Codable {
            public var count: Int
            public var sum: Double
            public var min: Double
            public var max: Double
            public var average: Double
            public var sumOfSquares: Double
            public var standardDeviation: Double
            
            public init(
                count: Int = 0,
                sum: Double = 0.0,
                min: Double = 0.0,
                max: Double = 0.0,
                average: Double = 0.0,
                sumOfSquares: Double = 0.0,
                standardDeviation: Double = 0.0
            ) {
                self.count = count
                self.sum = sum
                self.min = min
                self.max = max
                self.average = average
                self.sumOfSquares = sumOfSquares
                self.standardDeviation = standardDeviation
            }
        }
        
        public var commits: Int
        public var integrations: Int
        public var successfulIntegrations: Int
        public var coverageDelta: Int
        public var testAdditionRate: Int
        public var sinceDate: Date
        public var analysisWarnings: Analysis
        public var averageIntegrationTime: Analysis
        public var errors: Analysis
        public var improvedPerformanceTests: Analysis
        public var regressedPerformanceTests: Analysis
        public var testFailures: Analysis
        public var tests: Analysis
        public var warnings: Analysis
        
        public var bestSuccessStreak: Integration?
        public var lastCleanIntegration: Integration?
        
        public init(
            commits: Int = 0,
            integrations: Int = 0,
            successfulIntegrations: Int = 0,
            coverageDelta: Int = 0,
            testAdditionRate: Int = 0,
            sinceDate: Date = Date(),
            analysisWarnings: Bot.Stats.Analysis = Analysis(),
            averageIntegrationTime: Bot.Stats.Analysis = Analysis(),
            errors: Bot.Stats.Analysis = Analysis(),
            improvedPerformanceTests: Bot.Stats.Analysis = Analysis(),
            regressedPerformanceTests: Bot.Stats.Analysis = Analysis(),
            testFailures: Bot.Stats.Analysis = Analysis(),
            tests: Bot.Stats.Analysis = Analysis(),
            warnings: Bot.Stats.Analysis = Analysis(),
            bestSuccessStreak: Integration? = nil,
            lastCleanIntegration: Integration? = nil
        ) {
            self.commits = commits
            self.integrations = integrations
            self.successfulIntegrations = successfulIntegrations
            self.coverageDelta = coverageDelta
            self.testAdditionRate = testAdditionRate
            self.sinceDate = sinceDate
            self.analysisWarnings = analysisWarnings
            self.averageIntegrationTime = averageIntegrationTime
            self.errors = errors
            self.improvedPerformanceTests = improvedPerformanceTests
            self.regressedPerformanceTests = regressedPerformanceTests
            self.testFailures = testFailures
            self.tests = tests
            self.warnings = warnings
            self.bestSuccessStreak = bestSuccessStreak
            self.lastCleanIntegration = lastCleanIntegration
        }
    }
}

public extension Bot.Stats {
    /// The percentage of 'successful' integrations.
    var successRate: Double {
        let rate = Double(successfulIntegrations) / Double(integrations)
        
        guard !rate.isNaN else {
            return 0.0
        }
        
        return rate
    }
}

public extension Bot.Stats.Analysis {
    /// Expresses the `average` in terms of _minutes_ rather than _seconds_.
    var averageMinutes: Int {
        return Int(average / 60.0)
    }
}
