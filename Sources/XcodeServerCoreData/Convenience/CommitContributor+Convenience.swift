import XcodeServer
#if canImport(CoreData)
import CoreData

public extension CommitContributor {
    private static var jsonEncoder: JSONEncoder = JSONEncoder()
    private static var jsonDecoder: JSONDecoder = JSONDecoder()
    
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
        get {
            guard let data = self.emailsData else {
                return []
            }
            
            do {
                return try Self.jsonDecoder.decode([String].self, from: data)
            } catch {
                print(error)
                return []
            }
        }
        set {
            do {
                emailsData = try Self.jsonEncoder.encode(newValue)
            } catch {
                print(error)
            }
        }
    }
}

public extension CommitContributor {
    func update(_ contributor: SourceControl.Contributor) {
        displayName = contributor.displayName
        emailAddresses = contributor.emails
        name = contributor.name
    }
}

/*
 extension XcodeServerCoreData.CommitContributor {
     public func update(withCommitContributor contributor: XCSCommitContributor) {
         self.name = contributor.name
         self.displayName = contributor.displayName
         if let emails = contributor.emails {
             self.emailAddresses = emails
         }
     }
 }
 */

#endif
