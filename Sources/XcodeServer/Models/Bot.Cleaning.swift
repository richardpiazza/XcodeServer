public extension Bot {
    /// Integration cleaning schedule
    enum Cleaning: Int, Codable {
        case never = 0
        case always = 1
        case daily = 2
        case weekly = 3
    }
}
