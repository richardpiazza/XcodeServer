import Foundation
import CoreData
import XcodeServerCommon

public class Issue: NSManagedObject {
    
    public var typeOfIssue: IssueType {
        guard let rawValue = self.type else {
            return .unknown
        }
        
        guard let enumeration = IssueType(rawValue: rawValue) else {
            return .unknown
        }
        
        return enumeration
    }
}
