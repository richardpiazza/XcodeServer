import Foundation
import CoreDataPlus
import XcodeServer
#if canImport(CoreData)
import CoreData

public class ManagedCommitContributor: NSManagedObject {

}

extension ManagedCommitContributor {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedCommitContributor> {
        return NSFetchRequest<ManagedCommitContributor>(entityName: "ManagedCommitContributor")
    }

    @NSManaged public var displayName: String?
    @NSManaged public var emailsData: Data?
    @NSManaged public var name: String?
    @NSManaged public var commit: ManagedCommit?

}

extension ManagedCommitContributor {
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
                return try PersistentContainer.jsonDecoder.decode([String].self, from: data)
            } catch {
                PersistentContainer.logger.error("Failed to get 'emailsData': \(String(data: data, encoding: .utf8) ?? "")", metadata: ["localizedDescription": .string(error.localizedDescription)])
                return []
            }
        }
        set {
            do {
                emailsData = try PersistentContainer.jsonEncoder.encode(newValue)
            } catch {
                PersistentContainer.logger.error("Failed to set 'emailsData': \(newValue)", metadata: ["localizedDescription": .string(error.localizedDescription)])
            }
        }
    }
}

extension ManagedCommitContributor {
    func update(_ contributor: SourceControl.Contributor) {
        displayName = contributor.displayName
        emailAddresses = contributor.emails
        name = contributor.name
    }
}

extension SourceControl.Contributor {
    init(_ contributor: ManagedCommitContributor) {
        self.init()
        name = contributor.name ?? ""
        displayName = contributor.displayName ?? ""
        emails = contributor.emailAddresses
    }
}
#endif
