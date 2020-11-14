import XcodeServer
import Dispatch
import Foundation
import SWCompression
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

public protocol CredentialDelegate: class {
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
    
    /// A general completion handler for HTTP requests.
    public typealias DataTaskCompletion = (_ statusCode: Int, _ headers: [String: String]?, _ data: Data?, _ error: Swift.Error?) -> Void
    public typealias CodableTaskCompletion<D: Decodable> = (_ statusCode: Int, _ headers: [String: String]?, _ data: D?, _ error: Swift.Error?) -> Void
    
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
    
    public let fqdn: String
    public var baseURL: URL
    public var jsonEncoder: JSONEncoder = XCSClient.jsonEncoder
    public var jsonDecoder: JSONDecoder = XCSClient.jsonDecoder
    internal let internalQueue: DispatchQueue = DispatchQueue(label: "XcodeServer.XcodeServerAPI.APIClient")
    internal let returnQueue: DispatchQueue
    
    /// Delegate responsible for handling all authentication needs.
    public var credentialDelegate: CredentialDelegate?
    
    init(fqdn: String, dispatchQueue: DispatchQueue, credentialDelegate: CredentialDelegate?) throws {
        guard let url = URL(string: "https://\(fqdn):20343/api") else {
            throw Error.fqdn
        }
        
        self.fqdn = fqdn
        baseURL = url
        returnQueue = dispatchQueue
        self.credentialDelegate = credentialDelegate
    }
    
    final func decompress(data: Data) throws -> Data {
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
    
    final func serverResult<T>(_ statusCode: Int, _ headers: [String: String]?, data: T?, _ error: Swift.Error?) -> Result<T, Error> {
        guard statusCode != 401 else {
            return .failure(Error.authorization)
        }
        
        guard statusCode == 200 || statusCode == 201 else {
            return .failure(Error.response(innerError: error))
        }
        
        guard let result = data else {
            return .failure(Error.serialization(innerError: error))
        }
        
        return .success(result)
    }
    
    /// Convenience method for generating and executing a request using the `GET` http method.
    public func getPath(_ path: String, queryItems: [URLQueryItem]? = nil, completion: @escaping DataTaskCompletion) {
        completion(0, nil, nil, Error.notImplemented)
    }
    
    /// Convenience method for generating and executing a request using the `PUT` http method.
    public func putData(_ data: Data?, path: String, queryItems: [URLQueryItem]? = nil, completion: @escaping DataTaskCompletion) {
        completion(0, nil, nil, Error.notImplemented)
    }
    
    /// Convenience method for generating and executing a request using the `POST` http method.
    public func postData(_ data: Data?, path: String, queryItems: [URLQueryItem]? = nil, completion: @escaping DataTaskCompletion) {
        completion(0, nil, nil, Error.notImplemented)
    }
    
    /// Convenience method for generating and executing a request using the `PATCH` http method.
    public func patchData(_ data: Data?, path: String, queryItems: [URLQueryItem]? = nil, completion: @escaping DataTaskCompletion) {
        completion(0, nil, nil, Error.notImplemented)
    }
    
    /// Convenience method for generating and executing a request using the `DELETE` http method.
    public func deletePath(_ path: String, queryItems: [URLQueryItem]? = nil, completion: @escaping DataTaskCompletion) {
        completion(0, nil, nil, Error.notImplemented)
    }
    
    func encode<E: Encodable>(_ encodable: E?) throws -> Data? {
        var data: Data? = nil
        if let encodable = encodable {
            data = try jsonEncoder.encode(encodable)
        }
        return data
    }
    
    func decode<D: Decodable>(statusCode: Int, headers: [String: String]?, data: Data?, error: Swift.Error?, completion: @escaping CodableTaskCompletion<D>) {
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
    
    public func getPath<D: Decodable>(_ path: String, queryItems: [URLQueryItem]? = nil, completion: @escaping CodableTaskCompletion<D>) {
        self.getPath(path, queryItems: queryItems) { (statusCode, headers, data: Data?, error) in
            self.decode(statusCode: statusCode, headers: headers, data: data, error: error, completion: completion)
        }
    }
    
    public func putData<E: Encodable, D: Decodable>(_ encodable: E?, path: String, queryItems: [URLQueryItem]? = nil, completion: @escaping CodableTaskCompletion<D>) {
        var data: Data? = nil
        do {
            data = try self.encode(encodable)
        } catch {
            completion(0, nil, nil, error)
            return
        }
        
        self.putData(data, path: path, queryItems: queryItems) { (statusCode, headers, data: Data?, error) in
            self.decode(statusCode: statusCode, headers: headers, data: data, error: error, completion: completion)
        }
    }
    
    public func postData<E: Encodable, D: Decodable>(_ encodable: E?, path: String, queryItems: [URLQueryItem]? = nil, completion: @escaping CodableTaskCompletion<D>) {
        var data: Data? = nil
        do {
            data = try self.encode(encodable)
        } catch {
            completion(0, nil, nil, error)
            return
        }
        
        self.postData(data, path: path, queryItems: queryItems) { (statusCode, headers, data: Data?, error) in
            self.decode(statusCode: statusCode, headers: headers, data: data, error: error, completion: completion)
        }
    }
    
    public func postData<D: Decodable>(_ data: Data?, path: String, queryItems: [URLQueryItem]? = nil, completion: @escaping CodableTaskCompletion<D>) {
        self.postData(data, path: path, queryItems: queryItems) { (statusCode, headers, data: Data?, error) in
            self.decode(statusCode: statusCode, headers: headers, data: data, error: error, completion: completion)
        }
    }
    
    public func patchData<E: Encodable, D: Decodable>(_ encodable: E?, path: String, queryItems: [URLQueryItem]? = nil, completion: @escaping CodableTaskCompletion<D>) {
        var data: Data? = nil
        do {
            data = try self.encode(encodable)
        } catch {
            completion(0, nil, nil, error)
            return
        }
        
        self.patchData(data, path: path, queryItems: queryItems) { (statusCode, headers, data: Data?, error) in
            self.decode(statusCode: statusCode, headers: headers, data: data, error: error, completion: completion)
        }
    }
    
    public func deletePath<D: Decodable>(_ path: String, queryItems: [URLQueryItem]? = nil, completion: @escaping CodableTaskCompletion<D>) {
        self.deletePath(path, queryItems: queryItems) { (statusCode, headers, data: Data?, error) in
            self.decode(statusCode: statusCode, headers: headers, data: data, error: error, completion: completion)
        }
    }
}

// MARK: - Connection/Versioning
public extension XCSClient {
    /// Requests the '`/ping`' endpoint from the Xcode Server API.
    func ping(_ completion: @escaping (Result<Void, Error>) -> Void) {
        getPath("ping") { (statusCode, headers, data: Data?, error) in
            guard statusCode == 204 else {
                completion(.failure(Error.xcodeServer))
                return
            }
            
            completion(.success(()))
        }
    }
    
    func versions(_ completion: @escaping (Result<(XCSVersion, Int?), Error>) -> Void) {
        getPath("versions") { (statusCode, headers, data: XCSVersion?, error) in
            guard statusCode != 401 else {
                completion(.failure(Error.authorization))
                return
            }
            
            guard statusCode == 200 else {
                completion(.failure(Error.response(innerError: error)))
                return
            }
            
            guard let result = data else {
                completion(.failure(Error.serialization(innerError: error)))
                return
            }
            
            var apiVersion: Int?
            
            if let responseHeaders = headers {
                if let version = responseHeaders[Headers.xcsAPIVersion] {
                    apiVersion = Int(version)
                }
            }
            
            completion(.success((result, apiVersion)))
        }
    }
}

// MARK: - Bots
public extension XCSClient {
    /// Requests the '`/bots`' endpoint from the Xcode Server API.
    func bots(_ completion: @escaping (Result<[XCSBot], Error>) -> Void) {
        struct Response: Codable {
            public var count: Int
            public var results: [XCSBot]
        }
        
        getPath("bots") { (statusCode, headers, data: Response?, error) in
            completion(self.serverResult(statusCode, headers, data: data?.results, error))
        }
    }
    
    /// Requests the '`/bots/{id}`' endpoint from the Xcode Server API.
    func bot(withIdentifier identifier: String, completion: @escaping (Result<XCSBot, Error>) -> Void) {
        getPath("bots/\(identifier)") { (statusCode, headers, data: XCSBot?, error) in
            completion(self.serverResult(statusCode, headers, data: data, error))
        }
    }
    
    /// Requests the '`/bots/{id}/stats`' endpoint from the Xcode Server API.
    func stats(forBotWithIdentifier identifier: String, completion: @escaping (Result<XCSStats, Error>) -> Void) {
        getPath("bots/\(identifier)/stats") { (statusCode, headers, data: XCSStats?, error) in
            completion(self.serverResult(statusCode, headers, data: data, error))
        }
    }
}

// MARK: - Integrations
public extension XCSClient {
    /// Requests the '`/integrations`' endpoint from the Xcode Server API.
    func integrations(completion: @escaping (Result<[XCSIntegration], Error>) -> Void) {
        struct Response: Codable {
            public var count: Int
            public var results: [XCSIntegration]
        }
        
        getPath("integrations") { (statusCode, headers, data: Response?, error) in
            completion(self.serverResult(statusCode, headers, data: data?.results, error))
        }
    }
    
    /// Requests the '`/bots/{id}/integrations`' endpoint from the Xcode Server API.
    func integrations(forBotWithIdentifier identifier: String, completion: @escaping (Result<[XCSIntegration], Error>) -> Void) {
        struct Response: Codable {
            public var count: Int
            public var results: [XCSIntegration]
        }
        
        getPath("bots/\(identifier)/integrations") { (statusCode, headers, data: Response?, error) in
            completion(self.serverResult(statusCode, headers, data: data?.results, error))
        }
    }
    
    /// Posts a request to the '`/bots/{id}`' endpoint from the Xcode Server API.
    func runIntegration(forBotWithIdentifier identifier: String, completion: @escaping (Result<XCSIntegration, Error>) -> Void) {
        postData(nil, path: "bots/\(identifier)/integrations") { (statusCode, headers, data: XCSIntegration?, error) in
            completion(self.serverResult(statusCode, headers, data: data, error))
        }
    }
    
    /// Requests the '`/integrations/{id}`' endpoint from the Xcode Server API.
    func integration(withIdentifier identifier: String, completion: @escaping (Result<XCSIntegration, Error>) -> Void) {
        getPath("integrations/\(identifier)") { (statusCode, headers, data: XCSIntegration?, error) in
            completion(self.serverResult(statusCode, headers, data: data, error))
        }
    }
}

// MARK: - Commits
public extension XCSClient {
    /// Requests the '`/integrations/{id}/commits`' endpoint from the Xcode Server API.
    func commits(forIntegrationWithIdentifier identifier: String, completion: @escaping (Result<[XCSCommit], Error>) -> Void) {
        struct Response: Codable {
            public var count: Int
            public var results: [XCSCommit]
        }
        
        getPath("integrations/\(identifier)/commits") { (statusCode, headers, data: Response?, error) in
            completion(self.serverResult(statusCode, headers, data: data?.results, error))
        }
    }
}

// MARK: - Issues
public extension XCSClient {
    /// Requests the '`/integrations/{id}/issues`' endpoint from the Xcode Server API.
    func issues(forIntegrationWithIdentifier identifier: String, completion: @escaping (Result<XCSIssues, Error>) -> Void) {
        getPath("integrations/\(identifier)/issues") { (statusCode, headers, data: XCSIssues?, error) in
            completion(self.serverResult(statusCode, headers, data: data, error))
        }
    }
}

// MARK: - Coverage
public extension XCSClient {
    
    /// Requests the '`/integrations/{id}/coverage`' endpoint from the Xcode Server API.
    func coverage(forIntegrationWithIdentifier identifier: String, completion: @escaping (Result<XCSCoverageHierarchy?, Swift.Error>) -> Void) {
        getPath("integrations/\(identifier)/coverage") { (statusCode, headers, data: Data?, error) in
            guard statusCode != 401 else {
                completion(.failure(Error.authorization))
                return
            }
            
            guard statusCode == 200 else {
                if statusCode == 404 {
                    // 404 is a valid response, no coverage data.
                    completion(.success(nil))
                } else {
                    completion(.failure(Error.response(innerError: error)))
                }
                return
            }
            
            guard let result = data else {
                completion(.failure(Error.serialization(innerError: error)))
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
public extension XCSClient {
    /// Retrieve the _post-integration_ asset archive.
    ///
    /// Requests the '`/integrations/{id}/assets`' endpoint from the Xcode Server API.
    /// This `.tar` file will contain all of the integration logs, test summaries, and IPA.
    func archive(forIntegrationWithIdentifier identifier: String, completion: @escaping (Result<(String, Data), Error>) -> Void) {
        getPath("integrations/\(identifier)/assets") { (statusCode, headers, data: Data?, error) in
            guard statusCode != 401 else {
                completion(.failure(Error.authorization))
                return
            }
            
            guard statusCode == 200 else {
                completion(.failure(Error.response(innerError: error)))
                return
            }
            
            var filename: String = "File.tar.gz"
            if let disposition = headers?["Content-Disposition"]?.filenameFromContentDisposition() {
                filename = disposition
            }
            
            guard let result = data else {
                completion(.failure(Error.serialization(innerError: error)))
                return
            }
            
            completion(.success((filename, result)))
        }
    }
}

extension APIClient: AnyQueryable {
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
