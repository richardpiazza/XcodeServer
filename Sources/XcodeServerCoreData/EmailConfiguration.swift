import Foundation
import CoreData
import XcodeServerCommon

@objc(EmailConfiguration)
public class EmailConfiguration: NSManagedObject {
    
    public convenience init?(managedObjectContext: NSManagedObjectContext, trigger: Trigger) {
        self.init(managedObjectContext: managedObjectContext)
        self.trigger = trigger
        self.emailComitters = false
        self.emailTypeRawValue = 0
        self.hour = 0
        self.includeBotConfiguration = false
        self.includeCommitMessages = false
        self.includeIssueDetails = false
        self.includeLogs = false
        self.includeResolvedIssues = false
        self.minutesAfterHour = 0
        self.weeklyScheduleDay = 0
    }
}

// MARK: - CoreData Properties
public extension EmailConfiguration {
    
    @nonobjc class func fetchRequest() -> NSFetchRequest<EmailConfiguration> {
        return NSFetchRequest<EmailConfiguration>(entityName: entityName)
    }
    
    @NSManaged var additionalRecipients: String?
    @NSManaged var allowedDomainNamesData: Data?
    @NSManaged var ccAddressesData: Data?
    @NSManaged var emailComitters: Bool
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
    @NSManaged var trigger: Trigger?
    @NSManaged var weeklyScheduleDay: Int16
}

public extension EmailConfiguration {
    var emailType: EmailType {
        get {
            return EmailType(rawValue: emailTypeRawValue) ?? .integrationReport
        }
        set {
            emailTypeRawValue = newValue.rawValue
        }
    }
}
