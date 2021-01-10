import XcodeServer
import XcodeServerCoreData
import Foundation
#if canImport(CoreData)
import CoreData

//@objc(Repository)
class Repository: NSManagedObject {

}

extension Repository {

    @nonobjc class func fetchRequest() -> NSFetchRequest<Repository> {
        return NSFetchRequest<Repository>(entityName: "Repository")
    }

    @NSManaged var branchIdentifier: String?
    @NSManaged var branchOptions: Int16
    @NSManaged var identifier: String?
    @NSManaged var locationType: String?
    @NSManaged var system: String?
    @NSManaged var url: String?
    @NSManaged var workingCopyPath: String?
    @NSManaged var workingCopyState: Int32
    @NSManaged var commits: NSSet?
    @NSManaged var configurations: NSSet?

}

// MARK: Generated accessors for commits
extension Repository {

    @objc(addCommitsObject:)
    @NSManaged public func addToCommits(_ value: Commit)

    @objc(removeCommitsObject:)
    @NSManaged public func removeFromCommits(_ value: Commit)

    @objc(addCommits:)
    @NSManaged public func addToCommits(_ values: NSSet)

    @objc(removeCommits:)
    @NSManaged public func removeFromCommits(_ values: NSSet)

}

// MARK: Generated accessors for configurations
extension Repository {

    @objc(addConfigurationsObject:)
    @NSManaged public func addToConfigurations(_ value: Configuration)

    @objc(removeConfigurationsObject:)
    @NSManaged public func removeFromConfigurations(_ value: Configuration)

    @objc(addConfigurations:)
    @NSManaged public func addToConfigurations(_ values: NSSet)

    @objc(removeConfigurations:)
    @NSManaged public func removeFromConfigurations(_ values: NSSet)

}

extension Repository {
    /// Retrieves all `Repository` entities from the Core Data `NSManagedObjectContext`
    static func repositories(in context: NSManagedObjectContext) -> [Repository] {
        let request = NSFetchRequest<Repository>(entityName: entityName)
        do {
            return try context.fetch(request)
        } catch {
            InternalLog.persistence.error("Failed to fetch repositories", error: error)
        }
        
        return []
    }
    
    /// Retrieves the first `Repository` entity from the Core Data `NSManagedObjectContext` that matches the specified
    /// id.
    static func repository(_ id: XcodeServer.SourceControl.Remote.ID, in context: NSManagedObjectContext) -> Repository? {
        let request = NSFetchRequest<Repository>(entityName: entityName)
        request.predicate = NSPredicate(format: "identifier = %@", argumentArray: [id])
        do {
            return try context.fetch(request).first
        } catch {
            InternalLog.persistence.error("Failed to fetch repository '\(id)'", error: error)
        }
        
        return nil
    }
}

extension Repository {
    func update(_ remote: SourceControl.Remote, context: NSManagedObjectContext) {
        identifier = remote.id
        system = remote.system
        url = remote.url
        update(remote.commits, context: context)
    }
    
    func update(_ blueprint: SourceControl.Blueprint, context: NSManagedObjectContext) {
        if !blueprint.primaryRemoteIdentifier.isEmpty {
            identifier = blueprint.primaryRemoteIdentifier
        }
        
        if let remote = blueprint.remotes.first(where: { $0.id == identifier }) {
            system = remote.system
            url = remote.url
        }
        
        if let location = blueprint.locations[identifier ?? ""] {
            branchIdentifier = location.id
            branchOptions = Int16(location.branchOptions)
            locationType = location.locationType
        }
        
        if let _ = blueprint.authenticationStrategies[identifier ?? ""] {
        }
    }
    
    func update(_ commits: Set<SourceControl.Commit>, integration: Integration? = nil, context: NSManagedObjectContext) {
        for commit in commits {
            let _commit: Commit
            if let existing = Commit.commit(commit.id, in: context) {
                _commit = existing
            } else {
                InternalLog.persistence.debug("Creating COMMIT for Repository [\(identifier ?? "")]")
                _commit = context.make()
                addToCommits(_commit)
            }
            
            _commit.update(commit, integration: integration, context: context)
        }
    }
}

extension SourceControl.Remote {
    init(_ repository: Repository) {
        self.init(id: repository.identifier ?? "")
        system = repository.system ?? ""
        url = repository.url ?? ""
        locations = Set([SourceControl.Location(repository)])
        if let commits = repository.commits as? Set<Commit> {
            self.commits = Set(commits.map { SourceControl.Commit($0) })
        }
    }
}

extension SourceControl.Location {
    init(_ repository: Repository) {
        self.init(id: repository.branchIdentifier ?? "")
        branchOptions = Int(repository.branchOptions)
        locationType = repository.locationType ?? ""
    }
}
#endif
