import Foundation
#if canImport(CoreData)
import CoreData

@objc(EmailConfiguration)
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
#endif
