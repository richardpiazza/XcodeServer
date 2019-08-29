import Foundation

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
