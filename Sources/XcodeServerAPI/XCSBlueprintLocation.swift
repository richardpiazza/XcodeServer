import Foundation

public struct XCSBlueprintLocation: Codable {
    
    enum CodingKeys: String, CodingKey {
        case branchIdentifier = "DVTSourceControlBranchIdentifierKey"
        case locationRevision = "DVTSourceControlLocationRevisionKey"
        case branchOptions = "DVTSourceControlBranchOptionsKey"
        case locationType = "DVTSourceControlWorkspaceBlueprintLocationTypeKey"
        case remoteName = "DVTSourceControlBranchRemoteNameKey"
    }
    
    public var branchIdentifier: String?
    public var locationRevision: String?
    public var branchOptions: Int?
    public var locationType: String?
    public var remoteName: String?
}
