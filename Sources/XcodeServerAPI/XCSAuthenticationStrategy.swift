/// The strategy for how to authenticate against remote source control repositories.
public struct XCSAuthenticationStrategy: Codable {
    
    enum CodingKeys: String, CodingKey {
        case authenticationType = "DVTSourceControlWorkspaceBlueprintRemoteRepositoryAuthenticationTypeKey"
    }
    
    ///
    public var authenticationType: String?
}

// MARK: - Equatable
extension XCSAuthenticationStrategy: Equatable {
}

// MARK: - Hashable
extension XCSAuthenticationStrategy: Hashable {
}
