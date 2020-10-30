/// A set of instructions telling the bot what to check out and how.
///
/// It provides the URIs for all repositories to check out files from, the branch to check out, the relative layout on
/// disk, and the relative location of the project or workspace to build out of. It also can include the authentication
/// information to use when checking out, although this information is sent only to the server and is never returned
/// from it.
public struct XCSRepositoryBlueprint: Codable {
    
    enum CodingKeys: String, CodingKey {
        case identifier = "DVTSourceControlWorkspaceBlueprintIdentifierKey"
        case name = "DVTSourceControlWorkspaceBlueprintNameKey"
        case version = "DVTSourceControlWorkspaceBlueprintVersion"
        case relativePathToProject = "DVTSourceControlWorkspaceBlueprintRelativePathToProjectKey"
        case primaryRemoteRepository = "DVTSourceControlWorkspaceBlueprintPrimaryRemoteRepositoryKey"
        case remoteRepositories = "DVTSourceControlWorkspaceBlueprintRemoteRepositoriesKey"
        case locations = "DVTSourceControlWorkspaceBlueprintLocationsKey"
        case workingCopyRepositoryLocations = "DVTSourceControlWorkspaceBlueprintWorkingCopyRepositoryLocationsKey"
        case remoteRepositoryAuthenticationStrategies = "DVTSourceControlWorkspaceBlueprintRemoteRepositoryAuthenticationStrategiesKey"
        case workingCopyStates = "DVTSourceControlWorkspaceBlueprintWorkingCopyStatesKey"
        case workingCopyPaths = "DVTSourceControlWorkspaceBlueprintWorkingCopyPathsKey"
        case additionalValidationRemoteRepositories = "DVTSourceControlWorkspaceBlueprintAdditionalValidationRemoteRepositoriesKey"
    }
    
    public var identifier: String
    public var name: String
    public var version: Int
    public var relativePathToProject: String?
    public var primaryRemoteRepository: String?
    public var remoteRepositories: [XCSRemoteRepository]?
    public var locations: [String : XCSBlueprintLocation]?
    public var workingCopyRepositoryLocations: XCSRepositoryLocation?
    public var remoteRepositoryAuthenticationStrategies: [String : XCSAuthenticationStrategy]?
    public var workingCopyStates: [String : Double]?
    public var workingCopyPaths: [String : String]?
    public var additionalValidationRemoteRepositories: [XCSRemoteRepository]?
}

// MARK: - Identifiable
extension XCSRepositoryBlueprint: Identifiable {
    public var id: String {
        get { identifier }
        set { identifier = newValue }
    }
}

// MARK: - Equatable
extension XCSRepositoryBlueprint: Equatable {
}

// MARK: - Hashable
extension XCSRepositoryBlueprint: Hashable {
}

public extension XCSRepositoryBlueprint {
    var repositoryIds: [String] {
        return locations?.compactMap({ $0.key }).sorted() ?? []
    }
}
