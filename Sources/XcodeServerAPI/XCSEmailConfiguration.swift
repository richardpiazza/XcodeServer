import XcodeServerCommon

///
public struct XCSEmailConfiguration: Codable {
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
