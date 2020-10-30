import XcodeServer
import Foundation

public extension SourceControl.Commit {
    init(_ commit: XCSRepositoryCommit, remote: SourceControl.Remote.ID?, integration: Integration.ID?) {
        self.init(id: commit.hash ?? "")
        message = commit.message ?? ""
        date = commit.timestamp ?? Date()
        isMerge = commit.isMerge ?? ""
        remoteId = remote
        integrationId = integration
        if let contributor = commit.contributor {
            self.contributor = SourceControl.Contributor(contributor)
        }
        if let changes = commit.commitChangeFilePaths {
            self.changes = changes.map { SourceControl.Change($0) }
        }
    }
}

public extension SourceControl.Contributor {
    init(_ contributor: XCSCommitContributor) {
        self.init()
        name = contributor.name ?? ""
        displayName = contributor.displayName ?? ""
        emails = contributor.emails ?? []
    }
}

public extension SourceControl.Change {
    init(_ change: XCSCommitChangeFilePath) {
        self.init()
        filePath = change.filePath
        status = change.status
    }
}

public extension SourceControl.Blueprint {
    init(_ blueprint: XCSRepositoryBlueprint) {
        self.init(id: blueprint.id)
        name = blueprint.name
        version = blueprint.version
        relativePathToProject = blueprint.relativePathToProject ?? ""
        primaryRemoteIdentifier = blueprint.primaryRemoteRepository ?? ""
        if let remotes = blueprint.remoteRepositories {
            self.remotes = Set(remotes.map { SourceControl.Remote($0) })
        }
        if let locations = blueprint.locations {
            locations.forEach { (key, value) in
                self.locations[key] = SourceControl.Location(value)
            }
        }
        if let strategies = blueprint.remoteRepositoryAuthenticationStrategies {
            strategies.forEach { (key, value) in
                self.authenticationStrategies[key] = SourceControl.AuthenticationStrategy(value)
            }
        }
        if let remotes = blueprint.additionalValidationRemoteRepositories {
            additionalValidationRemotes = Set(remotes.map { SourceControl.Remote($0) })
        }
    }
}

public extension SourceControl.Remote {
    init(_ remote: XCSRemoteRepository) {
        self.init(id: remote.identifier ?? "")
        system = remote.system ?? ""
        url = remote.url ?? ""
        trustedCertFingerprint = remote.trustedCertFingerprint ?? ""
        enforceTrustCertFingerprint = remote.enforceTrustCertFingerprint ?? false
    }
}

public extension SourceControl.Location {
    init(_ location: XCSBlueprintLocation) {
        self.init(id: location.branchIdentifier ?? "")
        branchOptions = location.branchOptions ?? 0
        locationType = location.locationType ?? ""
        locationRevision = location.locationRevision ?? ""
        remoteName = location.remoteName ?? ""
    }
}

public extension SourceControl.AuthenticationStrategy {
    init(_ strategy: XCSAuthenticationStrategy) {
        self.init()
        self.type = strategy.authenticationType ?? ""
    }
}
