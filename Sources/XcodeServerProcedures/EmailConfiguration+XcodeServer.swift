import Foundation
import XcodeServerCommon
import XcodeServerAPI
import XcodeServerCoreData

extension EmailConfiguration {
    public func update(withEmailConfiguration configuration: XCSEmailConfiguration) {
        if #available(macOS 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *) {
            if let ccas = configuration.ccAddresses {
                do {
                    self.ccAddressesData = try JSON.jsonEncoder.encode(ccas)
                } catch {
                    print(error)
                }
            }
            if let adn = configuration.allowedDomainNames {
                do {
                    self.allowedDomainNamesData = try JSON.jsonEncoder.encode(adn)
                } catch {
                    print(error)
                }
            }
        }
        
        self.additionalRecipients = configuration.additionalRecipients?.joined(separator: ",")
        self.emailComitters = configuration.emailCommitters ?? false
        self.emailType = configuration.type ?? .integrationReport
        self.fromAddress = configuration.fromAddress
        self.hour = Int16(configuration.hour ?? 0)
        self.includeBotConfiguration = configuration.includeBotConfiguration ?? false
        self.includeCommitMessages = configuration.includeCommitMessages ?? false
        self.includeIssueDetails = configuration.includeIssueDetails ?? false
        self.includeLogs = configuration.includeLogs ?? false
        self.includeResolvedIssues = configuration.includeResolvedIssues ?? false
        self.minutesAfterHour = Int16(configuration.minutesAfterHour ?? 0)
        self.replyToAddress = configuration.replyToAddress
        self.weeklyScheduleDay = Int16(configuration.weeklyScheduleDay ?? 0)
    }
}
