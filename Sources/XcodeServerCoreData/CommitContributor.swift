import Foundation
import CoreData
import XcodeServerCommon
import XcodeServerAPI

public class CommitContributor: NSManagedObject {
    
    public convenience init?(managedObjectContext: NSManagedObjectContext, commit: Commit) {
        self.init(managedObjectContext: managedObjectContext)
        self.commit = commit
    }
    
    public func update(withCommitContributor contributor: XCSCommitContributor) {
        self.name = contributor.name
        self.displayName = contributor.displayName
        if let emails = contributor.emails {
            do {
                self.emailsData = try jsonEncoder.encode(emails)
            } catch {
                print(error)
            }
        }
    }
    
    public var initials: String? {
        var tempComponents: [String]? = nil
        
        if let name = self.name {
            tempComponents = name.components(separatedBy: " ")
        } else if let displayName = self.displayName {
            tempComponents = displayName.components(separatedBy: " ")
        }
        
        guard let components = tempComponents else {
            return nil
        }
        
        var initials = ""
        
        for component in components {
            guard component != "" else {
                continue
            }
            
            if let character = component.first {
                initials.append(character)
            }
        }
        
        return initials
    }
    
    public var emailAddresses: [String] {
        guard let data = self.emailsData else {
            return []
        }
        
        do {
            return try jsonDecoder.decode([String].self, from: data)
        } catch {
            print(error)
            return []
        }
    }
}
