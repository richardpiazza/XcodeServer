import XcodeServer
import Foundation
#if canImport(CoreData)

public extension SourceControl.Commit {
    init(_ commit: XcodeServerCoreData.Commit) {
        InternalLog.debug("Mapping XcodeServerCoreData.Commit [\(commit.commitHash)] to XcodeServer.SourceControl.Commit")
        self.init(id: commit.commitHash)
        message = commit.message ?? ""
        date = commit.date ?? Date()
        if let contributor = commit.commitContributor {
            self.contributor = SourceControl.Contributor(contributor)
        }
        
        if let changes = commit.commitChanges {
//            _ = changes.map({ $0.statusRawValue })
            self.changes = changes.map({ SourceControl.Change($0) })
        }
        
        if let blueprints = commit.revisionBlueprints, !blueprints.isEmpty {
            integrationId = blueprints.first?.integration?.identifier
        }
    }
}

public extension SourceControl.Contributor {
    init(_ contributor: CommitContributor) {
        InternalLog.debug("Mapping XcodeServerCoreData.CommitContributor to XcodeServer.SourceControl.Contributor")
        self.init()
        name = contributor.name ?? ""
        displayName = contributor.displayName ?? ""
        emails = contributor.emailAddresses
    }
}

public extension SourceControl.Change {
    init(_ change: CommitChange) {
        InternalLog.debug("Mapping XcodeServerCoreData.CommitChange to XcodeServer.SourceControl.Change")
        self.init()
        filePath = change.filePath ?? ""
        status = Int(change.statusRawValue)
    }
}

public extension SourceControl.Remote {
    init(_ repository: XcodeServerCoreData.Repository) {
        InternalLog.debug("Mapping XcodeServerCoreData.Repository [\(repository.identifier)] to XcodeServer.SourceControl.Remote")
        self.init(id: repository.identifier)
        system = repository.system ?? ""
        url = repository.url ?? ""
        locations = Set([SourceControl.Location(repository)])
        if let commits = repository.commits {
            self.commits = Set(commits.map { SourceControl.Commit($0) })
        }
    }
}

public extension SourceControl.Location {
    init(_ repository: XcodeServerCoreData.Repository) {
        InternalLog.debug("Mapping XcodeServerCoreData.Repository [\(repository.identifier)] to XcodeServer.SourceControl.Location")
        self.init(id: repository.branchIdentifier ?? "")
        branchOptions = Int(repository.branchOptions)
        locationType = repository.locationType ?? ""
    }
}

#endif
