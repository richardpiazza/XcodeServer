import Foundation
import CoreDataPlus
import XcodeServer
#if canImport(CoreData)
import CoreData

public class ManagedEmailConfiguration: NSManagedObject {

}

extension ManagedEmailConfiguration {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedEmailConfiguration> {
        return NSFetchRequest<ManagedEmailConfiguration>(entityName: "ManagedEmailConfiguration")
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
    @NSManaged public var trigger: ManagedTrigger?

}

extension ManagedEmailConfiguration {
    var emailType: Trigger.Email.Category {
        get { Trigger.Email.Category(rawValue: Int(emailTypeRawValue)) ?? .integrationReport }
        set { emailTypeRawValue = Int16(newValue.rawValue) }
    }
    
    var ccAddresses: [String] {
        get {
            guard let data = ccAddressesData else {
                return []
            }
            
            do {
                return try PersistentContainer.jsonDecoder.decode([String].self, from: data)
            } catch {
                PersistentContainer.logger.error("Failed to decode 'ccAddressesData'.", metadata: [
                    "UTF8": .string(String(data: data, encoding: .utf8) ?? ""),
                    "localizedDescription": .string(error.localizedDescription)
                ])
                return []
            }
        }
        set {
            do {
                ccAddressesData = try PersistentContainer.jsonEncoder.encode(newValue)
            } catch {
                PersistentContainer.logger.error("Failed to encode 'ccAddressesData'.", metadata: [
                    "UTF8": .stringConvertible(newValue),
                    "localizedDescription": .string(error.localizedDescription)
                ])
            }
        }
    }
    
    var allowedDomainNames: [String] {
        get {
            guard let data = allowedDomainNamesData else {
                return []
            }
            
            do {
                return try PersistentContainer.jsonDecoder.decode([String].self, from: data)
            } catch {
                PersistentContainer.logger.error("Failed to decode 'allowedDomainNamesData'.", metadata: [
                    "UTF8": .string(String(data: data, encoding: .utf8) ?? ""),
                    "localizedDescription": .string(error.localizedDescription)
                ])
                return []
            }
        }
        set {
            do {
                allowedDomainNamesData = try PersistentContainer.jsonEncoder.encode(newValue)
            } catch {
                PersistentContainer.logger.error("Failed to encode 'allowedDomainNamesData'.", metadata: [
                    "UTF8": .stringConvertible(newValue),
                    "localizedDescription": .string(error.localizedDescription)
                ])
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
    
    func update(_ email: Trigger.Email) {
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

extension Trigger.Email {
    init(_ email: ManagedEmailConfiguration) {
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
