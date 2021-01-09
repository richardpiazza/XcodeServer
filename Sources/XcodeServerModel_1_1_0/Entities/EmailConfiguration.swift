import XcodeServer
import XcodeServerCoreData
import Foundation
#if canImport(CoreData)
import CoreData

//@objc(EmailConfiguration)
public class EmailConfiguration: NSManagedObject {

}

extension EmailConfiguration {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EmailConfiguration> {
        return NSFetchRequest<EmailConfiguration>(entityName: "EmailConfiguration")
    }

    @NSManaged public var additionalRecipients: String?
    @NSManaged public var allowedDomainNamesData: Data?
    @NSManaged public var ccAddressesData: Data?
    @NSManaged public var emailCommitters: Bool
    @NSManaged public var emailTypeRawValue: Int16
    @NSManaged public var fromAddress: String?
    @NSManaged public var hour: Int16
    @NSManaged public var includeBotConfiguration: Bool
    @NSManaged public var includeCommitMessages: Bool
    @NSManaged public var includeIssueDetails: Bool
    @NSManaged public var includeLogs: Bool
    @NSManaged public var includeResolvedIssues: Bool
    @NSManaged public var minutesAfterHour: Int16
    @NSManaged public var replyToAddress: String?
    @NSManaged public var weeklyScheduleDay: Int16
    @NSManaged public var trigger: Trigger?

}

public extension EmailConfiguration {
    private static var jsonEncoder: JSONEncoder = JSONEncoder()
    private static var jsonDecoder: JSONDecoder = JSONDecoder()
    
    var emailType: XcodeServer.Trigger.Email.Category {
        get {
            return XcodeServer.Trigger.Email.Category(rawValue: Int(emailTypeRawValue)) ?? .integrationReport
        }
        set {
            emailTypeRawValue = Int16(newValue.rawValue)
        }
    }
    
    var ccAddresses: [String] {
        get {
            guard let data = ccAddressesData else {
                return []
            }
            
            do {
                return try Self.jsonDecoder.decode([String].self, from: data)
            } catch {
                InternalLog.coreData.error("", error: error)
                return []
            }
        }
        set {
            do {
                ccAddressesData = try Self.jsonEncoder.encode(newValue)
            } catch {
                InternalLog.coreData.error("", error: error)
            }
        }
    }
    
    var allowedDomainNames: [String] {
        get {
            guard let data = allowedDomainNamesData else {
                return []
            }
            
            do {
                return try Self.jsonDecoder.decode([String].self, from: data)
            } catch {
                InternalLog.coreData.error("", error: error)
                return []
            }
        }
        set {
            do {
                allowedDomainNamesData = try Self.jsonEncoder.encode(newValue)
            } catch {
                InternalLog.coreData.error("", error: error)
            }
        }
    }
    
    var recipients: [String] {
        get {
            guard let additionalRecipients = self.additionalRecipients, !additionalRecipients.isEmpty else {
                return []
            }
            
            return additionalRecipients.components(separatedBy: ",")
        }
        set {
            additionalRecipients = newValue.joined(separator: ",")
        }
    }
}

public extension EmailConfiguration {
    func update(_ email: XcodeServer.Trigger.Email) {
        recipients = email.additionalRecipients
        allowedDomainNames = email.allowedDomainNames
        ccAddresses = email.ccAddresses
        emailCommitters = email.emailCommitters
        emailType = email.type
        fromAddress = email.fromAddress
        hour = Int16(email.hour)
        includeBotConfiguration = email.includeBotConfiguration
        includeCommitMessages = email.includeCommitMessages
        includeIssueDetails = email.includeIssueDetails
        includeLogs = email.includeLogs
        includeResolvedIssues = email.includeResolvedIssues
        minutesAfterHour = Int16(email.minutesAfterHour)
        replyToAddress = email.replyToAddress
        weeklyScheduleDay = Int16(email.weeklyScheduleDay)
    }
}

public extension XcodeServer.Trigger.Email {
    init(_ email: EmailConfiguration) {
        self.init()
        type = email.emailType
        fromAddress = email.fromAddress ?? ""
        replyToAddress = email.replyToAddress ?? ""
        allowedDomainNames = email.allowedDomainNames
        additionalRecipients = email.recipients
        ccAddresses = email.ccAddresses
        weeklyScheduleDay = Int(email.weeklyScheduleDay)
        hour = Int(email.hour)
        minutesAfterHour = Int(email.minutesAfterHour)
        emailCommitters = email.emailCommitters
        includeBotConfiguration = email.includeBotConfiguration
        includeCommitMessages = email.includeCommitMessages
        includeIssueDetails = email.includeIssueDetails
        includeLogs = email.includeLogs
        includeResolvedIssues = email.includeResolvedIssues
    }
}
#endif
