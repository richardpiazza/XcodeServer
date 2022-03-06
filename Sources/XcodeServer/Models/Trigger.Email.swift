public extension Trigger {
    ///
    struct Email: Hashable, Codable {
        
        /// Type of email being sent.
        ///
        /// /Applications/Xcode.app/Contents/Developer/usr/share/xcs/xcsd/constants.js
        ///
        /// ```js
        /// // Trigger email type
        /// XCSTriggerIntegrationReport: 0,
        /// XCSTriggerDailyReport: 1,
        /// XCSTriggerWeeklyReport: 2,
        /// XCSTriggerNewIssueFoundEmail: 3,
        /// ```
        public enum Category: Int, Codable {
            case integrationReport = 0
            case dailyReport = 1
            case weeklyReport = 2
            case newIssueFoundEmail = 3
        }
        
        /// Schedule for issuing report emails.
        ///
        /// /Applications/Xcode.app/Contents/Developer/usr/share/xcs/xcsd/constants.js
        ///
        /// ```js
        /// // Email Report Schedules
        /// XCSReportScheduleDaily: 0,
        /// XCSReportScheduleWeekly: 1,
        /// XCSReportScheduleIntegration: 2
        /// ```
        public enum Schedule: Int, Codable {
            case daily = 0
            case weekly = 1
            case integration = 2
        }
        
        public var type: Category = .integrationReport
        public var fromAddress: String = ""
        public var replyToAddress: String = ""
        public var allowedDomainNames: [String] = []
        public var additionalRecipients: [String] = []
        public var ccAddresses: [String] = []
        
        // Schedule
        public var weeklyScheduleDay: Int = 0
        public var hour: Int = 0
        public var minutesAfterHour: Int = 0
        
        // Options
        public var emailCommitters: Bool = false
        public var includeBotConfiguration: Bool = false
        public var includeCommitMessages: Bool = false
        public var includeIssueDetails: Bool = false
        public var includeLogs: Bool = false
        public var includeResolvedIssues: Bool = false
        public var scmOptions: [String : Int] = [:]
        
        public init() {
        }
    }
}
