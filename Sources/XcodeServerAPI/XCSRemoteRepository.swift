import Foundation

public struct XCSRemoteRepository: Codable {
    
    enum CodingKeys: String, CodingKey {
        case identifier = "DVTSourceControlWorkspaceBlueprintRemoteRepositoryIdentifierKey"
        case system = "DVTSourceControlWorkspaceBlueprintRemoteRepositorySystemKey"
        case url = "DVTSourceControlWorkspaceBlueprintRemoteRepositoryURLKey"
        case trustedCertFingerprint = "DVTSourceControlWorkspaceBlueprintRemoteRepositoryTrustedCertFingerprintKey"
        case enforceTrustCertFingerprint = "DVTSourceControlWorkspaceBlueprintRemoteRepositoryEnforceTrustCertFingerprintKey"
    }
    
    public var identifier: String?
    public var system: String?
    public var url: String?
    public var trustedCertFingerprint: String?
    public var enforceTrustCertFingerprint: Bool?
}
