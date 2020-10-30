import Foundation

///
public enum ResultError: Error {
    case message(String)
    case error(Error)
}

// MARK: - LocalizedError
extension ResultError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .message(let value):
            return value
        case .error(let value):
            return value.localizedDescription
        }
    }
}

// MARK: - Predefined Errors
public extension ResultError {
    static func noBot(_ id: XcodeServer.Bot.ID) -> ResultError {
        return .message("No Bot with ID '\(id)'.")
    }
    
    static func noStatsForBot(_ id: XcodeServer.Bot.ID) -> ResultError {
        return .message("No Stats found for Bot with ID '\(id)'.")
    }
    
    static func noServer(_ id: XcodeServer.Server.ID) -> ResultError {
        return .message("No Server with ID '\(id)'.")
    }
    
    static func noIntegration(_ id: XcodeServer.Integration.ID) -> ResultError {
        return .message("No Integration with ID '\(id)'.")
    }
    
    static func noRemote(_ id: SourceControl.Remote.ID) -> ResultError {
        return .message("No Source Control Remote with ID '\(id)'.")
    }
}
