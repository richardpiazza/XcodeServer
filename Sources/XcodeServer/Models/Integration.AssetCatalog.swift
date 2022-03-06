public extension Integration {
    
    struct AssetCatalog: Hashable, Codable {
        public var triggerAssets: [Asset] = []
        public var sourceControlLog: Asset = Asset()
        public var buildServiceLog: Asset = Asset()
        public var xcodebuildLog: Asset?
        public var xcodebuildOutput: Asset?
        public var archive: Asset?
        public var product: Asset?
        
        public init() {
        }
    }
}
