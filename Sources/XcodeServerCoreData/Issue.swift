import Foundation
import CoreData
import XcodeServerCommon
import XcodeServerAPI

public class Issue: NSManagedObject {
    
    public func update(withIssue issue: XCSIssue) {
        self.identifier = issue._id
        self.revision = issue._rev
        self.status = issue.status as NSNumber?
        self.age = issue.age as NSNumber?
        self.type = issue.type
        self.issueType = issue.issueType
        self.message = issue.message
        self.fixItType = issue.fixItType
        self.testCase = issue.testCase
        self.documentFilePath = issue.documentFilePath
        self.documentLocationData = issue.documentLocationData
    }
    
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
