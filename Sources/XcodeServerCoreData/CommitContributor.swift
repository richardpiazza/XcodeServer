import Foundation
import CoreData
import XcodeServerCommon

public class CommitContributor: NSManagedObject {
    
    public convenience init?(managedObjectContext: NSManagedObjectContext, commit: Commit) {
        self.init(managedObjectContext: managedObjectContext)
        self.commit = commit
    }
    
}

// MARK: - CoreData Properties
public extension CommitContributor {
    
    @NSManaged var displayName: String?
    @NSManaged var emailsData: Data?
    @NSManaged var name: String?
    @NSManaged var commit: Commit?
    
}

public extension CommitContributor {
    var initials: String? {
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
    
    var emailAddresses: [String] {
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
