import Foundation
#if canImport(CoreData)
import CoreData

@objc(Repository)
public class Repository: NSManagedObject {

}

extension Repository {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Repository> {
        return NSFetchRequest<Repository>(entityName: "Repository")
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
#endif
