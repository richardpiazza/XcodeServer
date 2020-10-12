import XcodeServer
import Foundation
import SWCompression
import AsyncHTTPClient
import NIO
import NIOHTTP1
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

@available(*, deprecated, renamed: "APIClient.Error")
public typealias APIClientError = APIClient.Error
@available(*, deprecated, renamed: "APIClient.Headers")
public typealias APIClientHeaders = APIClient.Headers

public protocol APIClientAuthorizationDelegate: class {
    func credentials(for fqdn: String) -> (username: String, password: String)?
    @available(*, deprecated, renamed: "credentials(for:)")
    func authorization(for fqdn: String?) -> HTTP.Authorization?
}

public extension APIClientAuthorizationDelegate {
    @available(*, deprecated, renamed: "credentials(for:)")
    func authorization(for fqdn: String?) -> HTTP.Authorization? {
        guard let creds = credentials(for: fqdn ?? "") else {
            return nil
        }
        return .basic(username: creds.username, password: creds.password)
    }
}

public class APIClient {
    
    public enum Error: Swift.Error, LocalizedError {
        case fqdn
        case xcodeServer
        case authorization
        case response(innerError: Swift.Error?)
        case serialization(innerError: Swift.Error?)
        case invalidURL
        
        public var errorDescription: String? {
            switch self {
            case .fqdn: return "Attempted to initialize with an invalid FQDN."
            case .xcodeServer: return "This class was initialized without an XcodeServer entity."
            case .authorization: return "The server returned a 401 response code."
            case .response: return "The response did not contain valid data."
            case .serialization: return "The response object could not be cast into the requested type."
            case .invalidURL: return "Failed to construct a valid URL."
            }
        }
    }
    
    public struct Headers {
        public static let xcsAPIVersion = "x-xcsapiversion"
        
        @available(*, deprecated, renamed: "xcsAPIVersion")
        public static var xscAPIVersion: String {
            return xcsAPIVersion
        }
    }
    
    private static var rfc1123: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE',' dd MMM yyyy HH':'mm':'ss 'GMT'"
        formatter.timeZone = TimeZone(identifier: "GMT")!
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
    
    public static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return formatter
    }()
    
    public static let jsonEncoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(dateFormatter)
        return encoder
    }()
    
    public static let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }()
    
    private static var _eventLoopGroup: EventLoopGroup?
    public let fqdn: String
    public var baseURL: URL
    public let client: HTTPClient
    public var jsonEncoder: JSONEncoder = APIClient.jsonEncoder
    public var jsonDecoder: JSONDecoder = APIClient.jsonDecoder
    internal let internalQueue: DispatchQueue = DispatchQueue(label: "XcodeServer.XcodeServerAPI.APIClient")
    internal let returnQueue: DispatchQueue
    
    /// Delegate responsible for handling all authentication for
    /// `XCServerClient` instances.
    public var authorizationDelegate: APIClientAuthorizationDelegate?
    
    /// Initialize an Xcode Server API client
    ///
    /// - parameter fqdn: The Fully-Qualified-Domain-Name (or IP) of the Xcode Server (HOST ONLY)
    /// - parameter dispatchQueue: DispatchQueue on which all results will be returned (when not specified).
    /// - parameter authorizationDelegate: 
    public init(fqdn: String, dispatchQueue: DispatchQueue = .main, authorizationDelegate: APIClientAuthorizationDelegate? = nil) throws {
        guard let url = URL(string: "https://\(fqdn):20343/api") else {
            throw APIClient.Error.fqdn
        }
        
        self.fqdn = fqdn
        baseURL = url
        
        var config = HTTPClient.Configuration()
        config.tlsConfiguration = .forClient(certificateVerification: .none)
        
        let provider: HTTPClient.EventLoopGroupProvider
        if Self._eventLoopGroup != nil {
            provider = .shared(Self._eventLoopGroup!)
        } else {
            provider = .createNew
        }
        
        client = .init(eventLoopGroupProvider: provider, configuration: config)
        
        if Self._eventLoopGroup == nil {
            Self._eventLoopGroup = client.eventLoopGroup
        }
        
        returnQueue = dispatchQueue
        self.authorizationDelegate = authorizationDelegate
    }
    
    deinit {
        try? client.syncShutdown()
    }
}

private extension APIClient {
    func request(method: HTTPMethod, path: String, queryItems: [URLQueryItem]?, data: Data?) throws -> HTTPClient.Request {
        let pathURL = baseURL.appendingPathComponent(path)
        
        var urlComponents = URLComponents(url: pathURL, resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = queryItems
        
        guard let url = urlComponents?.url else {
            throw APIClient.Error.invalidURL
        }
        
        var headers = HTTPHeaders()
        headers.add(name: "Date", value: Self.rfc1123.string(from: Date()))
        headers.add(name: "Accept", value: "application/json")
        headers.add(name: "Content-Type", value: "application.json")
        
        if let credentials = authorizationDelegate?.credentials(for: url.host ?? "") {
            let auth = HTTPClient.Authorization.basic(username: credentials.username, password: credentials.password)
            headers.add(name: "Authorization", value: auth.headerValue)
        }
        
        var body: HTTPClient.Body?
        if let data = data {
            body = .data(data)
            headers.add(name: "Content-Length", value: "\(data.count)")
        }
        
        return try HTTPClient.Request(url: url, method: method, headers: headers, body: body)
    }
    
    func serverResult<T>(_ statusCode: HTTPResponseStatus, _ headers: HTTPHeaders?, data: T?, _ error: Swift.Error?) -> Result<T, Error> {
        guard statusCode != .unauthorized else {
            return .failure(APIClient.Error.authorization)
        }
        
        guard statusCode == .ok || statusCode == .created else {
            return .failure(APIClient.Error.response(innerError: error))
        }
        
        guard let result = data else {
            return .failure(APIClient.Error.serialization(innerError: error))
        }
        
        return .success(result)
    }
    
    func decompress(data: Data) throws -> Data {
        let decompressedData = try BZip2.decompress(data: data)
        
        guard let decompressedString = String(data: decompressedData, encoding: .utf8) else {
            throw APIClient.Error.serialization(innerError: nil)
        }
        
        guard let firstBrace = decompressedString.range(of: "{") else {
            throw APIClient.Error.serialization(innerError: nil)
        }
        
        guard let lastBrace = decompressedString.range(of: "}", options: .backwards, range: nil, locale: nil) else {
            throw APIClient.Error.serialization(innerError: nil)
        }
        
        let range = decompressedString.index(firstBrace.lowerBound, offsetBy: 0)..<decompressedString.index(lastBrace.lowerBound, offsetBy: 1)
        let json = decompressedString[range]
        
        guard let validData = json.data(using: .utf8) else {
            throw APIClient.Error.serialization(innerError: nil)
        }
        
        return validData
    }
}

// MARK: - Connection/Versioning
public extension APIClient {
    
    /// Requests the '`/ping`' endpoint from the Xcode Server API.
    func ping(_ completion: @escaping (Result<Void, APIClient.Error>) -> Void) {
        get("ping") { (statusCode, headers, data: Data?, error) in
            guard statusCode == .noContent else {
                completion(.failure(APIClient.Error.xcodeServer))
                return
            }
            
            completion(.success(()))
        }
    }
    
    func versions(_ completion: @escaping (Result<(XCSVersion, Int?), APIClient.Error>) -> Void) {
        get("versions") { (statusCode, headers, data: XCSVersion?, error) in
            guard statusCode != .unauthorized else {
                completion(.failure(APIClient.Error.authorization))
                return
            }
            
            guard statusCode == .ok else {
                completion(.failure(APIClient.Error.response(innerError: error)))
                return
            }
            
            guard let result = data else {
                completion(.failure(APIClient.Error.serialization(innerError: error)))
                return
            }
            
            var apiVersion: Int?
            
            if let responseHeaders = headers {
                if let version = responseHeaders[APIClient.Headers.xcsAPIVersion].first {
                    apiVersion = Int(version)
                }
            }
            
            completion(.success((result, apiVersion)))
        }
    }
}

// MARK: - Bots
public extension APIClient {
    /// Requests the '`/bots`' endpoint from the Xcode Server API.
    func bots(_ completion: @escaping (Result<[XCSBot], Error>) -> Void) {
        struct Response: Codable {
            public var count: Int
            public var results: [XCSBot]
        }
        
        get("bots") { (statusCode, headers, data: Response?, error) in
            completion(self.serverResult(statusCode, headers, data: data?.results, error))
        }
    }
    
    /// Requests the '`/bots/{id}`' endpoint from the Xcode Server API.
    func bot(withIdentifier identifier: String, completion: @escaping (Result<XCSBot, Error>) -> Void) {
        get("bots/\(identifier)") { (statusCode, headers, data: XCSBot?, error) in
            completion(self.serverResult(statusCode, headers, data: data, error))
        }
    }
    
    /// Requests the '`/bots/{id}/stats`' endpoint from the Xcode Server API.
    func stats(forBotWithIdentifier identifier: String, completion: @escaping (Result<XCSStats, Error>) -> Void) {
        get("bots/\(identifier)/stats") { (statusCode, headers, data: XCSStats?, error) in
            completion(self.serverResult(statusCode, headers, data: data, error))
        }
    }
}

// MARK: - Integrations
public extension APIClient {
    /// Requests the '`/integrations`' endpoint from the Xcode Server API.
    func integrations(completion: @escaping (Result<[XCSIntegration], Error>) -> Void) {
        struct Response: Codable {
            public var count: Int
            public var results: [XCSIntegration]
        }
        
        get("integrations") { (statusCode, headers, data: Response?, error) in
            completion(self.serverResult(statusCode, headers, data: data?.results, error))
        }
    }
    
    /// Requests the '`/bots/{id}/integrations`' endpoint from the Xcode Server API.
    func integrations(forBotWithIdentifier identifier: String, completion: @escaping (Result<[XCSIntegration], Error>) -> Void) {
        struct Response: Codable {
            public var count: Int
            public var results: [XCSIntegration]
        }
        
        get("bots/\(identifier)/integrations") { (statusCode, headers, data: Response?, error) in
            completion(self.serverResult(statusCode, headers, data: data?.results, error))
        }
    }
    
    /// Posts a request to the '`/bots/{id}`' endpoint from the Xcode Server API.
    func runIntegration(forBotWithIdentifier identifier: String, completion: @escaping (Result<XCSIntegration, Error>) -> Void) {
        post(nil, path: "bots/\(identifier)/integrations") { (statusCode, headers, data: XCSIntegration?, error) in
            completion(self.serverResult(statusCode, headers, data: data, error))
        }
    }
    
    /// Requests the '`/integrations/{id}`' endpoint from the Xcode Server API.
    func integration(withIdentifier identifier: String, completion: @escaping (Result<XCSIntegration, Error>) -> Void) {
        get("integrations/\(identifier)") { (statusCode, headers, data: XCSIntegration?, error) in
            completion(self.serverResult(statusCode, headers, data: data, error))
        }
    }
}

// MARK: - Commits
public extension APIClient {
    /// Requests the '`/integrations/{id}/commits`' endpoint from the Xcode Server API.
    func commits(forIntegrationWithIdentifier identifier: String, completion: @escaping (Result<[XCSCommit], Error>) -> Void) {
        struct Response: Codable {
            public var count: Int
            public var results: [XCSCommit]
        }
        
        get("integrations/\(identifier)/commits") { (statusCode, headers, data: Response?, error) in
            completion(self.serverResult(statusCode, headers, data: data?.results, error))
        }
    }
}

// MARK: - Issues
public extension APIClient {
    /// Requests the '`/integrations/{id}/issues`' endpoint from the Xcode Server API.
    func issues(forIntegrationWithIdentifier identifier: String, completion: @escaping (Result<XCSIssues, Error>) -> Void) {
        get("integrations/\(identifier)/issues") { (statusCode, headers, data: XCSIssues?, error) in
            completion(self.serverResult(statusCode, headers, data: data, error))
        }
    }
}

// MARK: - Coverage
public extension APIClient {
    
    /// Requests the '`/integrations/{id}/coverage`' endpoint from the Xcode Server API.
    func coverage(forIntegrationWithIdentifier identifier: String, completion: @escaping (Result<XCSCoverageHierarchy?, Swift.Error>) -> Void) {
        get("integrations/\(identifier)/coverage") { (statusCode, headers, data: Data?, error) in
            guard statusCode != .unauthorized else {
                completion(.failure(APIClient.Error.authorization))
                return
            }
            
            guard statusCode == .ok else {
                if statusCode == .notFound {
                    // 404 is a valid response, no coverage data.
                    completion(.success(nil))
                } else {
                    completion(.failure(APIClient.Error.response(innerError: error)))
                }
                return
            }
            
            guard let result = data else {
                completion(.failure(APIClient.Error.serialization(innerError: error)))
                return
            }
            
            let decompressedData: Data
            do {
                decompressedData = try self.decompress(data: result)
            } catch let decompressionError {
                completion(.failure(decompressionError))
                return
            }
            
            let coverage: XCSCoverageHierarchy
            do {
                coverage = try self.jsonDecoder.decode(XCSCoverageHierarchy.self, from: decompressedData)
            } catch let serializationError {
                completion(.failure(serializationError))
                return
            }
            
            completion(.success(coverage))
        }
    }
}

// MARK: - Assets
public extension APIClient {
    
    /// Requests the '`/integrations/{id}/assets`' endpoint from the Xcode Server API.
    func assets(forIntegrationWithIdentifier identifier: String, completion: @escaping (Result<(String, Data), Error>) -> Void) {
        get("integrations/\(identifier)/assets") { (statusCode, headers, data: Data?, error) in
            guard statusCode != .unauthorized else {
                completion(.failure(APIClient.Error.authorization))
                return
            }
            
            guard statusCode == .ok else {
                completion(.failure(APIClient.Error.response(innerError: error)))
                return
            }
            
            var filename: String = "File.tar.gz"
            if let disposition = headers?["Content-Disposition"].first?.filenameFromContentDisposition() {
                filename = disposition
            }
            
            guard let result = data else {
                completion(.failure(APIClient.Error.serialization(innerError: error)))
                return
            }
            
            completion(.success((filename, result)))
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

// MARK: - Convenience
public extension APIClient {
    /// A general completion handler for HTTP requests.
    typealias DataTaskCompletion = (_ statusCode: HTTPResponseStatus, _ headers: HTTPHeaders?, _ data: Data?, _ error: Swift.Error?) -> Void
    
    /// Convenience method for generating and executing a request using the `GET` http method.
    func get(_ path: String, queryItems: [URLQueryItem]? = nil, completion: @escaping DataTaskCompletion) {
        do {
            let request = try self.request(method: .GET, path: path, queryItems: queryItems, data: nil)
            client.execute(request: request).whenComplete { (result) in
                switch result {
                case .failure(let error):
                    completion(.unhandled, nil, nil, error)
                case .success(let response):
                    var data: Data?
                    if let bytes = response.body {
                        var content = Data()
                        content.append(contentsOf: bytes.readableBytesView)
                        if content.count > 0 {
                            data = content
                        }
                    }
                    completion(response.status, response.headers, data, nil)
                }
            }
        } catch {
            completion(.unhandled, nil, nil, error)
        }
    }
    
    /// Convenience method for generating and executing a request using the `PUT` http method.
    func put(_ data: Data?, path: String, queryItems: [URLQueryItem]? = nil, completion: @escaping DataTaskCompletion) {
        do {
            let request = try self.request(method: .PUT, path: path, queryItems: queryItems, data: data)
            client.execute(request: request).whenComplete { (result) in
                switch result {
                case .failure(let error):
                    completion(.unhandled, nil, nil, error)
                case .success(let response):
                    var data: Data?
                    if let bytes = response.body {
                        var content = Data()
                        content.append(contentsOf: bytes.readableBytesView)
                        if content.count > 0 {
                            data = content
                        }
                    }
                    completion(response.status, response.headers, data, nil)
                }
            }
        } catch {
            completion(.unhandled, nil, nil, error)
        }
    }
    
    /// Convenience method for generating and executing a request using the `POST` http method.
    func post(_ data: Data?, path: String, queryItems: [URLQueryItem]? = nil, completion: @escaping DataTaskCompletion) {
        do {
            let request = try self.request(method: .POST, path: path, queryItems: queryItems, data: data)
            client.execute(request: request).whenComplete { (result) in
                switch result {
                case .failure(let error):
                    completion(.unhandled, nil, nil, error)
                case .success(let response):
                    var data: Data?
                    if let bytes = response.body {
                        var content = Data()
                        content.append(contentsOf: bytes.readableBytesView)
                        if content.count > 0 {
                            data = content
                        }
                    }
                    completion(response.status, response.headers, data, nil)
                }
            }
        } catch {
            completion(.unhandled, nil, nil, error)
        }
    }
    
    /// Convenience method for generating and executing a request using the `PATCH` http method.
    func patch(_ data: Data?, path: String, queryItems: [URLQueryItem]? = nil, completion: @escaping DataTaskCompletion) {
        do {
            let request = try self.request(method: .PATCH, path: path, queryItems: queryItems, data: data)
            client.execute(request: request).whenComplete { (result) in
                switch result {
                case .failure(let error):
                    completion(.unhandled, nil, nil, error)
                case .success(let response):
                    var data: Data?
                    if let bytes = response.body {
                        var content = Data()
                        content.append(contentsOf: bytes.readableBytesView)
                        if content.count > 0 {
                            data = content
                        }
                    }
                    completion(response.status, response.headers, data, nil)
                }
            }
        } catch {
            completion(.unhandled, nil, nil, error)
        }
    }
    
    /// Convenience method for generating and executing a request using the `DELETE` http method.
    func delete(_ path: String, queryItems: [URLQueryItem]? = nil, completion: @escaping DataTaskCompletion) {
        do {
            let request = try self.request(method: .DELETE, path: path, queryItems: queryItems, data: nil)
            client.execute(request: request).whenComplete { (result) in
                switch result {
                case .failure(let error):
                    completion(.unhandled, nil, nil, error)
                case .success(let response):
                    var data: Data?
                    if let bytes = response.body {
                        var content = Data()
                        content.append(contentsOf: bytes.readableBytesView)
                        if content.count > 0 {
                            data = content
                        }
                    }
                    completion(response.status, response.headers, data, nil)
                }
            }
        } catch {
            completion(.unhandled, nil, nil, error)
        }
    }
}

// MARK: - Codable Support
public extension APIClient {
    typealias CodableTaskCompletion<D: Decodable> = (_ statusCode: HTTPResponseStatus, _ headers: HTTPHeaders?, _ data: D?, _ error: Swift.Error?) -> Void
    
    func encode<E: Encodable>(_ encodable: E?) throws -> Data? {
        var data: Data? = nil
        if let encodable = encodable {
            data = try jsonEncoder.encode(encodable)
        }
        return data
    }
    
    func decode<D: Decodable>(statusCode: HTTPResponseStatus, headers: HTTPHeaders?, data: Data?, error: Swift.Error?, completion: @escaping CodableTaskCompletion<D>) {
        guard let data = data else {
            completion(statusCode, headers, nil, error)
            return
        }
        
        let result: D
        do {
            result = try jsonDecoder.decode(D.self, from: data)
            completion(statusCode, headers, result, nil)
        } catch let decoderError {
            completion(statusCode, headers, nil, decoderError)
        }
    }
    
    func get<D: Decodable>(_ path: String, queryItems: [URLQueryItem]? = nil, completion: @escaping CodableTaskCompletion<D>) {
        self.get(path, queryItems: queryItems) { (statusCode, headers, data: Data?, error) in
            self.decode(statusCode: statusCode, headers: headers, data: data, error: error, completion: completion)
        }
    }
    
    func put<E: Encodable, D: Decodable>(_ encodable: E?, path: String, queryItems: [URLQueryItem]? = nil, completion: @escaping CodableTaskCompletion<D>) {
        var data: Data? = nil
        do {
            data = try self.encode(encodable)
        } catch {
            completion(.unhandled, nil, nil, error)
            return
        }
        
        self.put(data, path: path, queryItems: queryItems) { (statusCode, headers, data: Data?, error) in
            self.decode(statusCode: statusCode, headers: headers, data: data, error: error, completion: completion)
        }
    }
    
    func post<E: Encodable, D: Decodable>(_ encodable: E?, path: String, queryItems: [URLQueryItem]? = nil, completion: @escaping CodableTaskCompletion<D>) {
        var data: Data? = nil
        do {
            data = try self.encode(encodable)
        } catch {
            completion(.unhandled, nil, nil, error)
            return
        }
        
        self.post(data, path: path, queryItems: queryItems) { (statusCode, headers, data: Data?, error) in
            self.decode(statusCode: statusCode, headers: headers, data: data, error: error, completion: completion)
        }
    }
    
    func post<D: Decodable>(_ data: Data?, path: String, queryItems: [URLQueryItem]? = nil, completion: @escaping CodableTaskCompletion<D>) {
        self.post(data, path: path, queryItems: queryItems) { (statusCode, headers, data: Data?, error) in
            self.decode(statusCode: statusCode, headers: headers, data: data, error: error, completion: completion)
        }
    }
    
    func patch<E: Encodable, D: Decodable>(_ encodable: E?, path: String, queryItems: [URLQueryItem]? = nil, completion: @escaping CodableTaskCompletion<D>) {
        var data: Data? = nil
        do {
            data = try self.encode(encodable)
        } catch {
            completion(.unhandled, nil, nil, error)
            return
        }
        
        self.patch(data, path: path, queryItems: queryItems) { (statusCode, headers, data: Data?, error) in
            self.decode(statusCode: statusCode, headers: headers, data: data, error: error, completion: completion)
        }
    }
    
    func delete<D: Decodable>(_ path: String, queryItems: [URLQueryItem]? = nil, completion: @escaping CodableTaskCompletion<D>) {
        self.delete(path, queryItems: queryItems) { (statusCode, headers, data: Data?, error) in
            self.decode(statusCode: statusCode, headers: headers, data: data, error: error, completion: completion)
        }
    }
}

private extension HTTPResponseStatus {
    static let unhandled: HTTPResponseStatus = .custom(code: 0, reasonPhrase: "Unknown Error / Unhandled Failure")
}

extension InternalLog {
    static let apiClient: InternalLog = InternalLog(name: "XcodeServerAPI.log", maxBytes: InternalLog.oneMB * 5)
}
