public extension SourceControl {
    ///
    struct Blueprint: Hashable, Identifiable, Codable {
        public var id: String
        public var name: String
        public var version: Int
        public var relativePathToProject: String
        public var primaryRemoteIdentifier: String
        public var remotes: Set<Remote>
        public var locations: [String : Location]
        public var authenticationStrategies: [String: AuthenticationStrategy]
        public var additionalValidationRemotes: Set<Remote>
        
        public init(
            id: Blueprint.ID = "",
            name: String = "",
            version: Int = 0,
            relativePathToProject: String = "",
            primaryRemoteIdentifier: String = "",
            remotes: Set<SourceControl.Remote> = [],
            locations: [String : SourceControl.Location] = [:],
            authenticationStrategies: [String : SourceControl.AuthenticationStrategy] = [:],
            additionalValidationRemotes: Set<SourceControl.Remote> = []
        ) {
            self.id = id
            self.name = name
            self.version = version
            self.relativePathToProject = relativePathToProject
            self.primaryRemoteIdentifier = primaryRemoteIdentifier
            self.remotes = remotes
            self.locations = locations
            self.authenticationStrategies = authenticationStrategies
            self.additionalValidationRemotes = additionalValidationRemotes
        }
    }
}
