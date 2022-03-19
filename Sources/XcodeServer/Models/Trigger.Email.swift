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
        
        public var type: Category
        public var fromAddress: String
        public var replyToAddress: String
        public var allowedDomainNames: [String]
        public var additionalRecipients: [String]
        public var ccAddresses: [String]
        
        // Schedule
        public var weeklyScheduleDay: Int
        public var hour: Int
        public var minutesAfterHour: Int
        
        // Options
        public var emailCommitters: Bool
        public var includeBotConfiguration: Bool
        public var includeCommitMessages: Bool
        public var includeIssueDetails: Bool
        public var includeLogs: Bool
        public var includeResolvedIssues: Bool
        public var scmOptions: [String : Int]
        
        public init(
            type: Trigger.Email.Category = .integrationReport,
            fromAddress: String = "",
            replyToAddress: String = "",
            allowedDomainNames: [String] = [],
            additionalRecipients: [String] = [],
            ccAddresses: [String] = [],
            weeklyScheduleDay: Int = 0,
            hour: Int = 0,
            minutesAfterHour: Int = 0,
            emailCommitters: Bool = false,
            includeBotConfiguration: Bool = false,
            includeCommitMessages: Bool = false,
            includeIssueDetails: Bool = false,
            includeLogs: Bool = false,
            includeResolvedIssues: Bool = false,
            scmOptions: [String : Int] = [:]
        ) {
            self.type = type
            self.fromAddress = fromAddress
            self.replyToAddress = replyToAddress
            self.allowedDomainNames = allowedDomainNames
            self.additionalRecipients = additionalRecipients
            self.ccAddresses = ccAddresses
            self.weeklyScheduleDay = weeklyScheduleDay
            self.hour = hour
            self.minutesAfterHour = minutesAfterHour
            self.emailCommitters = emailCommitters
            self.includeBotConfiguration = includeBotConfiguration
            self.includeCommitMessages = includeCommitMessages
            self.includeIssueDetails = includeIssueDetails
            self.includeLogs = includeLogs
            self.includeResolvedIssues = includeResolvedIssues
            self.scmOptions = scmOptions
        }
    }
}
