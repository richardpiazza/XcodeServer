import XcodeServer
#if canImport(CoreData)
import CoreData

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
                InternalLog.error("", error: error)
                return []
            }
        }
        set {
            do {
                ccAddressesData = try Self.jsonEncoder.encode(newValue)
            } catch {
                InternalLog.error("", error: error)
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
                InternalLog.error("", error: error)
                return []
            }
        }
        set {
            do {
                allowedDomainNamesData = try Self.jsonEncoder.encode(newValue)
            } catch {
                InternalLog.error("", error: error)
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

public extension XcodeServerCoreData.EmailConfiguration {
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
#endif
