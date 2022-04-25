import XcodeServer
import CoreDataPlus
import Foundation
import Logging
#if canImport(CoreData)
import CoreData

//@objc(EmailConfiguration)
class EmailConfiguration: NSManagedObject {

}

extension EmailConfiguration {

    @nonobjc class func fetchRequest() -> NSFetchRequest<EmailConfiguration> {
        return NSFetchRequest<EmailConfiguration>(entityName: "EmailConfiguration")
    }

    @NSManaged var additionalRecipients: String?
    @NSManaged var allowedDomainNamesData: Data?
    @NSManaged var ccAddressesData: Data?
    @NSManaged var emailCommitters: Bool
    @NSManaged var emailTypeRawValue: Int16
    @NSManaged var fromAddress: String?
    @NSManaged var hour: Int16
    @NSManaged var includeBotConfiguration: Bool
    @NSManaged var includeCommitMessages: Bool
    @NSManaged var includeIssueDetails: Bool
    @NSManaged var includeLogs: Bool
    @NSManaged var includeResolvedIssues: Bool
    @NSManaged var minutesAfterHour: Int16
    @NSManaged var replyToAddress: String?
    @NSManaged var weeklyScheduleDay: Int16
    @NSManaged var trigger: Trigger?

}

extension EmailConfiguration {
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
                PersistentContainer.logger.error("", metadata: ["localizedDescription": .string(error.localizedDescription)])
                return []
            }
        }
        set {
            do {
                ccAddressesData = try Self.jsonEncoder.encode(newValue)
            } catch {
                PersistentContainer.logger.error("", metadata: ["localizedDescription": .string(error.localizedDescription)])
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
                PersistentContainer.logger.error("", metadata: ["localizedDescription": .string(error.localizedDescription)])
                return []
            }
        }
        set {
            do {
                allowedDomainNamesData = try Self.jsonEncoder.encode(newValue)
            } catch {
                PersistentContainer.logger.error("", metadata: ["localizedDescription": .string(error.localizedDescription)])
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

extension EmailConfiguration {
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

extension XcodeServer.Trigger.Email {
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
