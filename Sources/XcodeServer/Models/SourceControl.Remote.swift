public extension SourceControl {
    /// AKA 'Repository'
    struct Remote: Hashable, Identifiable, Codable {
        public var id: String
        public var system: String
        public var url: String
        public var trustedCertFingerprint: String
        public var enforceTrustCertFingerprint: Bool
        public var locations: Set<SourceControl.Location>
        public var commits: Set<SourceControl.Commit>
        
        public init(
            id: Remote.ID = "",
            system: String = "",
            url: String = "",
            trustedCertFingerprint: String = "",
            enforceTrustCertFingerprint: Bool = false,
            locations: Set<SourceControl.Location> = [],
            commits: Set<SourceControl.Commit> = []
        ) {
            self.id = id
            self.system = system
            self.url = url
            self.trustedCertFingerprint = trustedCertFingerprint
            self.enforceTrustCertFingerprint = enforceTrustCertFingerprint
            self.locations = locations
            self.commits = commits
        }
    }
}

public extension SourceControl.Remote {
    /// A simplified name based off of the Repository URL.
    var name: String {
        guard let index = url.lastIndex(of: "/") else {
            return url
        }
        
        let start = url.index(index, offsetBy: 1)
        let path = String(url[start..<url.endIndex])
        return path.replacingOccurrences(of: ".git", with: "")
    }
}
