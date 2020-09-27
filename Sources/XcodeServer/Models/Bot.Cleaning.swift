public extension Bot {
    
    enum Cleaning: Int, Codable {
        case never = 0
        case always = 1
        case daily = 2
        case weekly = 3
    }
}

@available(*, deprecated, renamed: "Bot.Cleaning")
public typealias CleanSchedule = Bot.Cleaning
