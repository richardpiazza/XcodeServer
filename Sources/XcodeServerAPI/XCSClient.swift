import XcodeServer
import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
import Dispatch
import SWCompression
import AsyncHTTPClient
import NIO
import NIOHTTP1
import Logging

public protocol CredentialDelegate: AnyObject {
    func credentials(for server: Server.ID) -> (username: String, password: String)?
}

public class XCSClient {
    
    public enum Error: Swift.Error, LocalizedError {
        case fqdn
        case xcodeServer
        case authorization
        case response(innerError: Swift.Error?)
        case serialization(innerError: Swift.Error?)
        case invalidURL
        case notImplemented
        
        public var errorDescription: String? {
            switch self {
            case .fqdn: return "Attempted to initialize with an invalid FQDN."
            case .xcodeServer: return "This class was initialized without an XcodeServer entity."
            case .authorization: return "The server returned a 401 response code."
            case .response: return "The response did not contain valid data."
            case .serialization: return "The response object could not be cast into the requested type."
            case .invalidURL: return "Failed to construct a valid URL."
            case .notImplemented: return "The requested function has not been implemented."
            }
        }
    }
    
    public struct Headers {
        public static let xcsAPIVersion = "x-xcsapiversion"
    }
    
    internal static var rfc1123: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE',' dd MMM yyyy HH':'mm':'ss 'GMT'"
        formatter.timeZone = TimeZone(identifier: "GMT")!
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
    
    internal static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return formatter
    }()
    
    internal static let jsonEncoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(dateFormatter)
        return encoder
    }()
    
    internal static let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }()
    
    static let logger: Logger = Logger(label: "XcodeServer.API")
    
    public let fqdn: String
    public var baseURL: URL
    public var jsonEncoder: JSONEncoder = XCSClient.jsonEncoder
    public var jsonDecoder: JSONDecoder = XCSClient.jsonDecoder
    private let client: HTTPClient
    private let timeout: TimeAmount = .seconds(30)
    
    private static var eventLoopGroup: EventLoopGroup?
    
    /// Delegate responsible for handling all authentication needs.
    public var credentialDelegate: CredentialDelegate?
    
    public init(fqdn: String, credentialDelegate: CredentialDelegate?) throws {
        guard let url = URL(string: "https://\(fqdn):20343/api") else {
            throw Error.fqdn
        }
        
        self.fqdn = fqdn
        baseURL = url
        self.credentialDelegate = credentialDelegate
        
        let config = HTTPClient.Configuration(certificateVerification: .none)
        
        let provider: HTTPClient.EventLoopGroupProvider
        if Self.eventLoopGroup != nil {
            provider = .shared(Self.eventLoopGroup!)
        } else {
            provider = .createNew
        }
        
        client = .init(eventLoopGroupProvider: provider, configuration: config)
        
        if Self.eventLoopGroup == nil {
            Self.eventLoopGroup = client.eventLoopGroup
        }
    }
    
    deinit {
        try? client.syncShutdown()
    }
    
    private func decompress(data: Data) throws -> Data {
        let decompressedData = try BZip2.decompress(data: data)
        
        guard let decompressedString = String(data: decompressedData, encoding: .utf8) else {
            throw Error.serialization(innerError: nil)
        }
        
        guard let firstBrace = decompressedString.range(of: "{") else {
            throw Error.serialization(innerError: nil)
        }
        
        guard let lastBrace = decompressedString.range(of: "}", options: .backwards, range: nil, locale: nil) else {
            throw Error.serialization(innerError: nil)
        }
        
        let range = decompressedString.index(firstBrace.lowerBound, offsetBy: 0)..<decompressedString.index(lastBrace.lowerBound, offsetBy: 1)
        let json = decompressedString[range]
        
        guard let validData = json.data(using: .utf8) else {
            throw Error.serialization(innerError: nil)
        }
        
        return validData
    }
    
    private func clientRequest(path: String, method: HTTPMethod = .GET, queryItems: [URLQueryItem]? = nil, data: Data? = nil) throws -> HTTPClientRequest {
        let pathURL = baseURL.appendingPathComponent(path)
        
        var urlComponents = URLComponents(url: pathURL, resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = queryItems
        
        guard let url = urlComponents?.url else {
            throw Error.invalidURL
        }
        
        var headers = HTTPHeaders()
        headers.add(name: "Date", value: Self.rfc1123.string(from: Date()))
        headers.add(name: "Accept", value: "application/json")
        headers.add(name: "Content-Type", value: "application/json")
        
        if let credentials = credentialDelegate?.credentials(for: url.host ?? "") {
            let auth = HTTPClient.Authorization.basic(username: credentials.username, password: credentials.password)
            headers.add(name: "Authorization", value: auth.headerValue)
        }
        
        var body: HTTPClientRequest.Body?
        if let data = data {
            body = .bytes(ByteBuffer(data: data))
            headers.add(name: "Content-Length", value: "\(data.count)")
        }
        
        var request = HTTPClientRequest(url: url.absoluteString)
        request.method = method
        request.headers = headers
        request.body = body
        
        return request
    }
    
    /// Requests the '`/ping`' endpoint from the Xcode Server API.
    public func ping() async throws {
        Self.logger.info("Pinging SERVER [\(fqdn)]")
        let request = try clientRequest(path: "ping")
        let response = try await client.execute(request, timeout: timeout, logger: Self.logger)
        if response.status != .noContent {
            throw Error.xcodeServer
        }
    }
    
    public func versions() async throws -> (XCSVersion, Int) {
        Self.logger.info("Retrieving XCSVersion for SERVER [\(fqdn)]")
        let request = try clientRequest(path: "versions")
        let response = try await client.execute(request, timeout: timeout, logger: Self.logger)
        
        guard response.status != .unauthorized else {
            throw Error.authorization
        }
        
        guard response.status == .ok else {
            throw Error.response(innerError: nil)
        }
        
        let data = try await response.body.data
        let document = try jsonDecoder.decode(XCSVersion.self, from: data)
        let version = response.headers.first(name: Headers.xcsAPIVersion).flatMap(Int.init) ?? 19
        
        return (document, version)
    }
    
    /// Requests the '`/bots`' endpoint from the Xcode Server API.
    public func bots() async throws -> [XCSBot] {
        Self.logger.info("Retrieving [XCSBot] for SERVER [\(fqdn)]")
        
        struct Response: Codable {
            public var count: Int
            public var results: [XCSBot]
        }
        
        let request = try clientRequest(path: "bots")
        let response = try await client.execute(request, timeout: timeout, logger: Self.logger)
        let data = try await response.body.data
        let results = try jsonDecoder.decode(Response.self, from: data)
        return results.results
    }
    
    public func bot(withId id: Bot.ID) async throws -> XCSBot {
        Self.logger.info("Retrieving XCSBot [\(id)]")
        let request = try clientRequest(path: "bots/\(id)")
        let response = try await client.execute(request, timeout: timeout, logger: Self.logger)
        let data = try await response.body.data
        return try jsonDecoder.decode(XCSBot.self, from: data)
    }
    
    public func stats(forBot id: Bot.ID) async throws -> XCSStats {
        Self.logger.info("Retrieving XCSStats for Bot [\(id)]")
        let request = try clientRequest(path: "bots/\(id)/stats")
        let response = try await client.execute(request, timeout: timeout, logger: Self.logger)
        let data = try await response.body.data
        return try jsonDecoder.decode(XCSStats.self, from: data)
    }
    
    /// Requests the '`/integrations`' endpoint from the Xcode Server API.
    public func integrations() async throws -> [XCSIntegration] {
        Self.logger.info("Retrieving [XCSIntegration] for SERVER [\(fqdn)]")
        struct Response: Codable {
            public var count: Int
            public var results: [XCSIntegration]
        }
        
        let request = try clientRequest(path: "integrations")
        let response = try await client.execute(request, timeout: timeout, logger: Self.logger)
        let data = try await response.body.data
        let results = try jsonDecoder.decode(Response.self, from: data)
        return results.results
    }
    
    /// Requests the '`/integrations/{id}`' endpoint from the Xcode Server API.
    public func integration(withId id: Integration.ID) async throws -> XCSIntegration {
        Self.logger.info("Retrieving XCSIntegration [\(id)]")
        let request = try clientRequest(path: "integrations/\(id)")
        let response = try await client.execute(request, timeout: timeout, logger: Self.logger)
        let data = try await response.body.data
        return try jsonDecoder.decode(XCSIntegration.self, from: data)
    }
    
    /// Requests the '`/bots/{id}/integrations`' endpoint from the Xcode Server API.
    public func integrations(forBot id: Bot.ID) async throws -> [XCSIntegration] {
        Self.logger.info("Retrieving [XCSIntegration] for BOT [\(id)]")
        struct Response: Codable {
            public var count: Int
            public var results: [XCSIntegration]
        }
        
        let request = try clientRequest(path: "bots/\(id)/integrations")
        let response = try await client.execute(request, timeout: timeout, logger: Self.logger)
        let data = try await response.body.data
        let results = try jsonDecoder.decode(Response.self, from: data)
        return results.results
    }
    
    /// Posts a request to the '`/bots/{id}/integrations`' endpoint on the Xcode Server API.
    public func runIntegration(forBot id: Bot.ID) async throws -> XCSIntegration {
        Self.logger.info("Requesting XCSIntegration for BOT [\(id)]")
        let request = try clientRequest(path: "bots/\(id)/integrations", method: .POST)
        let response = try await client.execute(request, timeout: timeout, logger: Self.logger)
        let data = try await response.body.data
        return try jsonDecoder.decode(XCSIntegration.self, from: data)
    }
    
    /// Requests the '`/integrations/{id}/commits`' endpoint from the Xcode Server API.
    public func commits(forIntegration id: Integration.ID) async throws -> [XCSCommit] {
        Self.logger.info("Retrieving [XCSCommit] for INTEGRATION [\(id)]")
        struct Response: Codable {
            public var count: Int
            public var results: [XCSCommit]
        }
        
        let request = try clientRequest(path: "integrations/\(id)/commits")
        let response = try await client.execute(request, timeout: timeout, logger: Self.logger)
        let data = try await response.body.data
        let results = try jsonDecoder.decode(Response.self, from: data)
        return results.results
    }
    
    /// Requests the '`/integrations/{id}/issues`' endpoint from the Xcode Server API.
    public func issues(forIntegration id: Integration.ID) async throws -> XCSIssues {
        Self.logger.info("Retrieving XCSIssues for INTEGRATION [\(id)]")
        let request = try clientRequest(path: "integrations/\(id)/issues")
        let response = try await client.execute(request, timeout: timeout, logger: Self.logger)
        let data = try await response.body.data
        return try jsonDecoder.decode(XCSIssues.self, from: data)
    }
    
    /// Requests the '`/integrations/{id}/coverage`' endpoint from the Xcode Server API.
    public func coverage(forIntegration id: Integration.ID) async throws -> XCSCoverageHierarchy? {
        Self.logger.info("Retrieving XCSCoverageHierarchy for INTEGRATION [\(id)]")
        let request = try clientRequest(path: "integrations/\(id)/coverage")
        let response = try await client.execute(request, timeout: timeout, logger: Self.logger)
        
        switch response.status {
        case .unauthorized:
            throw Error.authorization
        case .notFound:
            // 404 is a valid response, no coverage data.
            return nil
        default:
            guard response.status == .ok else {
                throw Error.response(innerError: nil)
            }
        }
        
        let data = try await response.body.data
        let decompressedData = try decompress(data: data)
        return try jsonDecoder.decode(XCSCoverageHierarchy.self, from: decompressedData)
    }
    
    /// Retrieve the _post-integration_ asset archive.
    ///
    /// Requests the '`/integrations/{id}/assets`' endpoint from the Xcode Server API.
    /// This `.tar` file will contain all of the integration logs, test summaries, and IPA.
    public func archive(forIntegration id: Integration.ID) async throws -> (String, Data) {
        Self.logger.info("Retrieving ARCHIVE for INTEGRATION [\(id)]")
        let request = try clientRequest(path: "integrations/\(id)/assets")
        let response = try await client.execute(request, timeout: timeout, logger: Self.logger)
        
        switch response.status {
        case .unauthorized:
            throw Error.authorization
        default:
            guard response.status == .ok else {
                throw Error.response(innerError: nil)
            }
        }
        
        var filename = "File.tar.gz"
        if let value = response.headers.first(name: "Content-Disposition")?.filenameFromContentDisposition() {
            filename = value
        }
        
        let data = try await response.body.data
        return (filename, data)
    }
}

private extension HTTPClientResponse.Body {
    var data: Data {
        get async throws {
            var data = Data()
            for try await buffer in self {
                data.append(Data(buffer: buffer))
            }
            return data
        }
    }
}

private extension StringProtocol {
    func filenameFromContentDisposition() -> String? {
        guard let firstQuote = self.firstIndex(of: "\"") else {
            return nil
        }
        let start = self.index(firstQuote, offsetBy: 1)
        let end = self.index(endIndex, offsetBy: -1)
        return String(self[start..<end])
    }
}
