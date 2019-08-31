import Foundation
import CoreData

public class EmailConfiguration: NSManagedObject {
    
    public convenience init?(managedObjectContext: NSManagedObjectContext, trigger: Trigger) {
        self.init(managedObjectContext: managedObjectContext)
        self.trigger = trigger
    }
}

// MARK: - CoreData Properties
public extension EmailConfiguration {
    
    @nonobjc class func fetchRequest() -> NSFetchRequest<EmailConfiguration> {
        return NSFetchRequest<EmailConfiguration>(entityName: entityName)
    }
    
    @NSManaged var additionalRecipients: String?
    @NSManaged var emailComitters: NSNumber?
    @NSManaged var includeCommitMessages: NSNumber?
    @NSManaged var includeIssueDetails: NSNumber?
    @NSManaged var ccAddressesData: Data?
    @NSManaged var allowedDomainNamesData: Data?
    @NSManaged var includeLogs: NSNumber?
    @NSManaged var replyToAddress: String?
    @NSManaged var includeBotConfiguration: NSNumber?
    @NSManaged var fromAddress: String?
    @NSManaged var emailTypeRawValue: NSNumber?
    @NSManaged var includeResolvedIssues: NSNumber?
    @NSManaged var weeklyScheduleDay: NSNumber?
    @NSManaged var minutesAfterHour: NSNumber?
    @NSManaged var hour: NSNumber?
    @NSManaged var trigger: Trigger?
    
}
