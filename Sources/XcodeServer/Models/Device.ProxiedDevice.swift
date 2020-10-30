public extension Device {
    
    struct ProxiedDevice: Hashable, Identifiable {
        public var id: String
        public var name: String = ""
        public var deviceType: String = ""
        public var modelName: String = ""
        public var modelCode: String = ""
        public var modelUTI: String = ""
        public var osVersion: String = ""
        public var platformIdentifier: String = ""
        public var architecture: String = ""
        public var isConnected: Bool = false
        public var isSimulator: Bool = false
        public var isRetina: Bool = false
        public var isServer: Bool = false
        public var isTrusted: Bool = false
        public var isSupported: Bool = false
        public var isEnabledForDevelopment: Bool = false
        
        public init(id: ProxiedDevice.ID = "") {
            self.id = id
        }
    }
}
