public extension Bot {
    /// Intervals available for `Schedule.periodic`.
    enum PeriodicInterval: Int, Codable {
        case never = 0
        case hourly = 1
        case daily = 2
        case weekly = 3
        case integration = 4
    }
}
