public typealias XCSProvisioningProfiles = [String : String]

///
public struct XCSExportOptions: Codable {
    ///
    public var method: String?
    ///
    public var teamID: String?
    ///
    public var uploadBitcode: Bool?
    ///
    public var stripSwiftSymbols: Bool?
    ///
    public var iCloudContainerEnvironment: String?
    ///
    public var signingCertificate: String?
    ///
    public var signingStyle: String?
    ///
    public var uploadSymbols: Bool?
    ///
    public var provisioningProfiles: XCSProvisioningProfiles?
}

// MARK: - Equatable
extension XCSExportOptions: Equatable {
}

// MARK: - Hashable
extension XCSExportOptions: Hashable {
}
