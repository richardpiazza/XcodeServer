public extension Bot {
    
    enum Coverage: Int, Codable {
        case disabled = 0
        case enabled = 1
        case useSchemeSetting = 2
    }
}

@available(*, deprecated, renamed: "Bot.Coverage")
public typealias CodeCoveragePreference = Bot.Coverage
