/// Parameters specified about how the Xcode Server handles device/certificate provisioning.
public struct XCSProvisioningConfiguration: Codable {
    public var addMissingDevicesToTeams: Bool
    public var manageCertsAndProfiles: Bool
}

// MARK: - Equatable
extension XCSProvisioningConfiguration: Equatable {
}

// MARK: - Hashable
extension XCSProvisioningConfiguration: Hashable {
}
