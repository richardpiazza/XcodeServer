///
public struct XCSEmailConfiguration: Codable {
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
    public enum EmailType: Int, Codable {
        case integrationReport = 0
        case dailyReport = 1
        case weeklyReport = 2
        case newIssueFoundEmail = 3
    }
    
    
    public var additionalRecipients: [String]?
    public var allowedDomainNames: [String]?
    public var ccAddresses: [String]?
    public var emailCommitters: Bool?
    public var type: EmailType?
    public var fromAddress: String?
    public var hour: Int?
    public var includeBotConfiguration: Bool?
    public var includeCommitMessages: Bool?
    public var includeIssueDetails: Bool?
    public var includeLogs: Bool?
    public var includeResolvedIssues: Bool?
    public var minutesAfterHour: Int?
    public var replyToAddress: String?
    public var scmOptions: [String : Int]?
    public var weeklyScheduleDay: Int?
}

// MARK: - Equatable
extension XCSEmailConfiguration: Equatable {
}

// MARK: - Hashable
extension XCSEmailConfiguration: Hashable {
}
