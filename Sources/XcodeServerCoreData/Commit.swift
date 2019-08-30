import Foundation
import CoreData
import XcodeServerCommon

public class Commit: NSManagedObject {
    
    public convenience init?(managedObjectContext: NSManagedObjectContext, identifier: String, repository: Repository) {
        self.init(managedObjectContext: managedObjectContext)
        self.commitHash = identifier
        self.repository = repository
    }
    
    public var commitTimestamp: Date? {
        guard let timestamp = self.timestamp else {
            return nil
        }
        
        return dateFormatter.date(from: timestamp)
    }
}
