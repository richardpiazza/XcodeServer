import Foundation
import CoreData

public extension EmailConfiguration {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<EmailConfiguration> {
        return NSFetchRequest<EmailConfiguration>(entityName: "EmailConfiguration")
    }
    
    @NSManaged public var additionalRecipients: String?
    @NSManaged public var emailComitters: NSNumber?
    @NSManaged public var includeCommitMessages: NSNumber?
    @NSManaged public var includeIssueDetails: NSNumber?
    @NSManaged public var ccAddressesData: Data?
    @NSManaged public var allowedDomainNamesData: Data?
    @NSManaged public var includeLogs: NSNumber?
    @NSManaged public var replyToAddress: String?
    @NSManaged public var includeBotConfiguration: NSNumber?
    @NSManaged public var fromAddress: String?
    @NSManaged public var emailTypeRawValue: NSNumber?
    @NSManaged public var includeResolvedIssues: NSNumber?
    @NSManaged public var weeklyScheduleDay: NSNumber?
    @NSManaged public var minutesAfterHour: NSNumber?
    @NSManaged public var hour: NSNumber?
    @NSManaged public var trigger: Trigger?
    
}
