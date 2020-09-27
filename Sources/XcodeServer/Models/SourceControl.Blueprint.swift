public extension SourceControl {
    
    struct Blueprint: Hashable, Identifiable {
        public var id: String
        public var name: String = ""
        public var version: Int = 0
        public var relativePathToProject: String = ""
        public var primaryRemoteIdentifier: String = ""
        public var remotes: Set<Remote> = []
        public var locations: [String : Location] = [:]
        public var authenticationStrategies: [String: AuthenticationStrategy] = [:]
        public var additionalValidationRemotes: Set<Remote> = []
        
        public init(id: Blueprint.ID = "") {
            self.id = id
        }
    }
}
