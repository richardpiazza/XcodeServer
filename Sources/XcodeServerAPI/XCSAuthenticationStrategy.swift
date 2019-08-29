import Foundation

public struct XCSAuthenticationStrategy: Codable {
    
    enum CodingKeys: String, CodingKey {
        case authenticationType = "DVTSourceControlWorkspaceBlueprintRemoteRepositoryAuthenticationTypeKey"
    }
    
    public var authenticationType: String?
}
