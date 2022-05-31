import Foundation
import CoreDataPlus
import XcodeServer
#if canImport(CoreData)
import CoreData

public class ManagedRepository: NSManagedObject {

}

extension ManagedRepository {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedRepository> {
        return NSFetchRequest<ManagedRepository>(entityName: "ManagedRepository")
    }

    @NSManaged public var branchIdentifier: String?
    @NSManaged public var branchOptions: Int16
    @NSManaged public var identifier: String?
    @NSManaged public var locationType: String?
    @NSManaged public var system: String?
    @NSManaged public var url: String?
    @NSManaged public var workingCopyPath: String?
    @NSManaged public var workingCopyState: Int32
    @NSManaged public var commits: NSSet?
    @NSManaged public var configurations: NSSet?

}

// MARK: Generated accessors for commits
extension ManagedRepository {

    @objc(addCommitsObject:)
    @NSManaged public func addToCommits(_ value: ManagedCommit)

    @objc(removeCommitsObject:)
    @NSManaged public func removeFromCommits(_ value: ManagedCommit)

    @objc(addCommits:)
    @NSManaged public func addToCommits(_ values: NSSet)

    @objc(removeCommits:)
    @NSManaged public func removeFromCommits(_ values: NSSet)

}

// MARK: Generated accessors for configurations
extension ManagedRepository {

    @objc(addConfigurationsObject:)
    @NSManaged public func addToConfigurations(_ value: ManagedConfiguration)

    @objc(removeConfigurationsObject:)
    @NSManaged public func removeFromConfigurations(_ value: ManagedConfiguration)

    @objc(addConfigurations:)
    @NSManaged public func addToConfigurations(_ values: NSSet)

    @objc(removeConfigurations:)
    @NSManaged public func removeFromConfigurations(_ values: NSSet)

}

extension ManagedRepository {
    static func fetchRemotes() -> NSFetchRequest<ManagedRepository> {
        fetchRequest()
    }
    
    static func fetchRemote(withId id: SourceControl.Remote.ID) -> NSFetchRequest<ManagedRepository> {
        let request = fetchRequest()
        request.predicate = NSPredicate(format: "%K = %@", #keyPath(ManagedRepository.identifier), id)
        return request
    }
    
    /// Retrieves all `ManagedRepository` entities from the Core Data `NSManagedObjectContext`
    static func repositories(in context: NSManagedObjectContext) -> [ManagedRepository] {
        let request = fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            PersistentContainer.logger.error("Failed to fetch `[ManagedRepository]`.", metadata: [
                "localizedDescription": .string(error.localizedDescription)
            ])
        }
        
        return []
    }
    
    /// Retrieves the first `ManagedRepository` entity from the Core Data `NSManagedObjectContext` that matches the specified id.
    static func repository(_ id: SourceControl.Remote.ID, in context: NSManagedObjectContext) -> ManagedRepository? {
        let request = fetchRequest()
        request.predicate = NSPredicate(format: "%K = %@", #keyPath(ManagedRepository.identifier), id)
        do {
            return try context.fetch(request).first
        } catch {
            PersistentContainer.logger.error("Failed to fetch `ManagedRepository`.", metadata: [
                "SourceControl.Remote.ID": .string(id),
                "localizedDescription": .string(error.localizedDescription)
            ])
        }
        
        return nil
    }
    
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
    
    func update(_ commits: Set<SourceControl.Commit>, integration: ManagedIntegration? = nil, context: NSManagedObjectContext) {
        for commit in commits {
            let _commit: ManagedCommit
            if let existing = ManagedCommit.commit(commit.id, in: context) {
                _commit = existing
            } else {
                PersistentContainer.logger.trace("Creating `ManagedCommit`.", metadata: [
                    "SourceControl.Remote.ID":  .string(identifier ?? "")
                ])
                _commit = context.make()
                addToCommits(_commit)
            }
            
            _commit.update(commit, integration: integration, context: context)
        }
    }
}

extension SourceControl.Remote {
    init(_ repository: ManagedRepository) {
        self.init(id: repository.identifier ?? "")
        system = repository.system ?? ""
        url = repository.url ?? ""
        locations = Set([SourceControl.Location(repository)])
        if let commits = repository.commits as? Set<ManagedCommit> {
            self.commits = Set(commits.map { SourceControl.Commit($0) })
        }
    }
}

extension SourceControl.Location {
    init(_ repository: ManagedRepository) {
        self.init(id: repository.branchIdentifier ?? "")
        branchOptions = Int(repository.branchOptions)
        locationType = repository.locationType ?? ""
    }
}
#endif
