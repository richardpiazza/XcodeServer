public extension Integration {
    ///
    struct AssetCatalog: Hashable, Codable {
        public var triggerAssets: [Asset]
        public var sourceControlLog: Asset
        public var buildServiceLog: Asset
        public var xcodebuildLog: Asset?
        public var xcodebuildOutput: Asset?
        public var archive: Asset?
        public var product: Asset?
        
        public init(
            triggerAssets: [Integration.Asset] = [],
            sourceControlLog: Integration.Asset = Asset(),
            buildServiceLog: Integration.Asset = Asset(),
            xcodebuildLog: Integration.Asset? = nil,
            xcodebuildOutput: Integration.Asset? = nil,
            archive: Integration.Asset? = nil,
            product: Integration.Asset? = nil
        ) {
            self.triggerAssets = triggerAssets
            self.sourceControlLog = sourceControlLog
            self.buildServiceLog = buildServiceLog
            self.xcodebuildLog = xcodebuildLog
            self.xcodebuildOutput = xcodebuildOutput
            self.archive = archive
            self.product = product
        }
    }
}
