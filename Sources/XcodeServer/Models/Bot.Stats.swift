import Foundation

public extension Bot {
    
    struct Stats: Hashable {
        
        public struct Analysis: Hashable {
            public var count: Int = 0
            public var sum: Double = 0.0
            public var min: Double = 0.0
            public var max: Double = 0.0
            public var average: Double = 0.0
            public var sumOfSquares: Double = 0.0
            public var standardDeviation: Double = 0.0
            
            public init() {
            }
        }
        
        public var commits: Int = 0
        public var integrations: Int = 0
        public var successfulIntegrations: Int = 0
        public var coverageDelta: Int = 0
        public var testAdditionRate: Int = 0
        public var sinceDate: Date = Date()
        public var analysisWarnings: Analysis = Analysis()
        public var averageIntegrationTime: Analysis = Analysis()
        public var errors: Analysis = Analysis()
        public var improvedPerformanceTests: Analysis = Analysis()
        public var regressedPerformanceTests: Analysis = Analysis()
        public var testFailures: Analysis = Analysis()
        public var tests: Analysis = Analysis()
        public var warnings: Analysis = Analysis()
        
        public var bestSuccessStreak: Integration?
        public var lastCleanIntegration: Integration?
        
        public init() {
            
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
