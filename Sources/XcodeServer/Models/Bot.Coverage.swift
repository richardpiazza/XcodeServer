public extension Bot {
    /// Code Coverage Setting
    enum Coverage: Int, Codable {
        case disabled = 0
        case enabled = 1
        case useSchemeSetting = 2
    }
}
