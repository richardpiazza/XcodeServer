import Foundation

public struct XCSEmailConfiguration: Codable {
    public var ccAddresses: [String]?
    public var allowedDomainNames: [String]?
    public var includeCommitMessages: Bool?
    public var includeLogs: Bool?
    public var replyToAddress: String?
    public var includeIssueDetails: Bool?
    public var includeBotConfiguration: Bool?
    public var additionalRecipients: [String]?
    public var scmOptions: [String : Int]?
    public var emailCommitters: Bool?
    public var fromAddress: String?
    public var type: XCSEmailType?
    public var includeResolvedIssues: Bool?
    public var weeklyScheduleDay: Int?
    public var minutesAfterHour: Int?
    public var hour: Int?
}
