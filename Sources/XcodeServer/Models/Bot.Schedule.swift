public extension Bot {
    /// Indicates how often should an Xcode Bot run.
    enum Schedule: Int, Codable {
        case periodic = 1
        case onCommit = 2
        case manual = 3
    }
}
