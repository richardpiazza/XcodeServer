import Foundation

/// Errors that are emitted from the **XcodeServer** library.
public enum XcodeServerError: LocalizedError {
    case botNotFound(_ id: Bot.ID)
    case integrationNotFound(_ id: Integration.ID)
    case notImplemented
    case remoteNotFound(_ id: SourceControl.Remote.ID)
    case serverId(_ id: Server.ID)
    case serverNotFound(_ id: Server.ID)
    case statusCode(UInt)
    case unauthorized
    case undefinedError(_ error: Error?)
    
    public init(_ error: Error) {
        switch error {
        case let xcodeServerError as XcodeServerError:
            self = xcodeServerError
        default:
            self = .undefinedError(error)
        }
    }
    
    public var errorDescription: String? {
        switch self {
        case .botNotFound(let id): return "Bot with ID '\(id)' was not found."
        case .integrationNotFound(let id): return "Integration with ID '\(id)' was not found."
        case .notImplemented: return "The function request has not been implemented. See documentation for additional details."
        case .remoteNotFound(let id): return "SourceControl.Remote with ID '\(id)' was not found."
        case .serverId(let id): return "The Server.ID '\(id)' was invalid for the request."
        case .serverNotFound(let id): return "Server with ID '\(id)' was not found."
        case .statusCode(let code): return "\(code): The status code did not match expectations."
        case .unauthorized: return "401: The authorization provided was rejected."
        case .undefinedError(.some(let error)): return "An error occurred: \(error.localizedDescription)"
        case .undefinedError(.none): return "An unknown error occurred"
        }
    }
}
