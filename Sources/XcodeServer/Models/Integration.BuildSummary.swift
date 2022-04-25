public extension Integration {
    ///
    struct BuildSummary: Hashable, Codable {
        public var errorCount: Int
        public var errorChange: Int
        public var warningCount: Int
        public var warningChange: Int
        public var testsCount: Int
        public var testsChange: Int
        public var testFailureCount: Int
        public var testFailureChange: Int
        public var analyzerWarningCount: Int
        public var analyzerWarningChange: Int
        public var regressedPerfTestCount: Int
        public var improvedPerfTestCount: Int
        public var codeCoveragePercentage: Int
        public var codeCoveragePercentageDelta: Int
        
        public init(
            errorCount: Int = 0,
            errorChange: Int = 0,
            warningCount: Int = 0,
            warningChange: Int = 0,
            testsCount: Int = 0,
            testsChange: Int = 0,
            testFailureCount: Int = 0,
            testFailureChange: Int = 0,
            analyzerWarningCount: Int = 0,
            analyzerWarningChange: Int = 0,
            regressedPerfTestCount: Int = 0,
            improvedPerfTestCount: Int = 0,
            codeCoveragePercentage: Int = 0,
            codeCoveragePercentageDelta: Int = 0
        ) {
            self.errorCount = errorCount
            self.errorChange = errorChange
            self.warningCount = warningCount
            self.warningChange = warningChange
            self.testsCount = testsCount
            self.testsChange = testsChange
            self.testFailureCount = testFailureCount
            self.testFailureChange = testFailureChange
            self.analyzerWarningCount = analyzerWarningCount
            self.analyzerWarningChange = analyzerWarningChange
            self.regressedPerfTestCount = regressedPerfTestCount
            self.improvedPerfTestCount = improvedPerfTestCount
            self.codeCoveragePercentage = codeCoveragePercentage
            self.codeCoveragePercentageDelta = codeCoveragePercentageDelta
        }
    }
}
