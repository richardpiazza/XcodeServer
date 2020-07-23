import Foundation
import SessionPlus
import SWCompression

public protocol APIClientAuthorizationDelegate: class {
    func authorization(for fqdn: String?) -> HTTP.Authorization?
}

public enum APIClientError: Swift.Error, LocalizedError {
    case fqdn
    case xcodeServer
    case authorization
    case response(innerError: Swift.Error?)
    case serialization(innerError: Swift.Error?)
    
    public var errorDescription: String? {
        switch self {
        case .fqdn: return "Attempted to initialize with an invalid FQDN."
        case .xcodeServer: return "This class was initialized without an XcodeServer entity."
        case .authorization: return "The server returned a 401 response code."
        case .response: return "The response did not contain valid data."
        case .serialization: return "The response object could not be cast into the requested type."
        }
    }
}

public struct APIClientHeaders {
    public static let xscAPIVersion = "x-xcsapiversion"
}

public class APIClient: HTTPClient, HTTPCodable {
    
    public static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return formatter
    }
    
    public static var jsonEncoder: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(dateFormatter)
        return encoder
    }
    
    public static var jsonDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }
    
    public var baseURL: URL
    public var session: URLSession
    public var authorization: HTTP.Authorization?
    public var jsonEncoder: JSONEncoder = APIClient.jsonEncoder
    public var jsonDecoder: JSONDecoder = APIClient.jsonDecoder
    
    /// Delegate responsible for handling all authentication for
    /// `XCServerClient` instances.
    public var authorizationDelegate: APIClientAuthorizationDelegate?
    
    public init(fqdn: String, authorizationDelegate: APIClientAuthorizationDelegate? = nil) throws {
        guard let url = URL(string: "https://\(fqdn):20343/api") else {
            throw APIClientError.fqdn
        }
        
        baseURL = url
        session = URLSession(configuration: URLSessionConfiguration.default, delegate: SelfSignedSessionDelegate(), delegateQueue: nil)
        self.authorizationDelegate = authorizationDelegate
    }
    
    public func request(method: HTTP.RequestMethod, path: String, queryItems: [URLQueryItem]?, data: Data?) throws -> URLRequest {
        let pathURL = baseURL.appendingPathComponent(path)
        
        var urlComponents = URLComponents(url: pathURL, resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = queryItems
        
        guard let url = urlComponents?.url else {
            throw HTTP.Error.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        if let data = data {
            request.httpBody = data
            request.setValue("\(data.count)", forHTTPHeader: HTTP.Header.contentLength)
        }
        request.setValue(HTTP.Header.dateFormatter.string(from: Date()), forHTTPHeader: HTTP.Header.date)
        request.setValue(HTTP.MIMEType.applicationJson.rawValue, forHTTPHeader: HTTP.Header.accept)
        request.setValue(HTTP.MIMEType.applicationJson.rawValue, forHTTPHeader: HTTP.Header.contentType)
        
        if let authorization = authorizationDelegate?.authorization(for: url.host) {
            request.setValue(authorization.headerValue, forHTTPHeader: HTTP.Header.authorization)
        }
        
        return request
    }
    
    public func execute(request: URLRequest, completion: @escaping HTTP.DataTaskCompletion) {
        let task: URLSessionDataTask
        do {
            task = try self.task(request: request, completion: completion)
        } catch {
            completion(0, nil, nil, error)
            return
        }
        
        task.resume()
    }
}

extension APIClient {
    private func serverResult<T>(_ statusCode: Int, _ headers: [AnyHashable : Any]?, data: T?, _ error: Swift.Error?) -> Result<T, Error> {
        guard statusCode != 401 else {
            return .failure(APIClientError.authorization)
        }
        
        guard statusCode == 200 || statusCode == 201 else {
            return .failure(APIClientError.response(innerError: error))
        }
        
        guard let result = data else {
            return .failure(APIClientError.serialization(innerError: error))
        }
        
        return .success(result)
    }
    
    private func decompress(data: Data) throws -> Data {
        let decompressedData = try BZip2.decompress(data: data)
        
        guard let decompressedString = String(data: decompressedData, encoding: .utf8) else {
            throw APIClientError.serialization(innerError: nil)
        }
        
        guard let firstBrace = decompressedString.range(of: "{") else {
            throw APIClientError.serialization(innerError: nil)
        }
        
        guard let lastBrace = decompressedString.range(of: "}", options: .backwards, range: nil, locale: nil) else {
            throw APIClientError.serialization(innerError: nil)
        }
        
        let range = decompressedString.index(firstBrace.lowerBound, offsetBy: 0)..<decompressedString.index(lastBrace.lowerBound, offsetBy: 1)
        let json = decompressedString[range]
        
        guard let validData = json.data(using: .utf8) else {
            throw APIClientError.serialization(innerError: nil)
        }
        
        return validData
    }
}

// MARK: - Connection/Versioning
public extension APIClient {
    
    /// Requests the '`/ping`' endpoint from the Xcode Server API.
    func ping(_ completion: @escaping (Result<Void, APIClientError>) -> Void) {
        get("ping") { (statusCode, headers, data: Data?, error) in
            guard statusCode == 204 else {
                completion(.failure(APIClientError.xcodeServer))
                return
            }
            
            completion(.success(()))
        }
    }
    
    func versions(_ completion: @escaping (Result<(XCSVersion, Int?), APIClientError>) -> Void) {
        get("versions") { (statusCode, headers, data: XCSVersion?, error) in
            guard statusCode != 401 else {
                completion(.failure(APIClientError.authorization))
                return
            }
            
            guard statusCode == 200 else {
                completion(.failure(APIClientError.response(innerError: error)))
                return
            }
            
            guard let result = data else {
                completion(.failure(APIClientError.serialization(innerError: error)))
                return
            }
            
            var apiVersion: Int?
            
            if let responseHeaders = headers {
                if let version = responseHeaders[APIClientHeaders.xscAPIVersion] as? String {
                    apiVersion = Int(version)
                } else if let version = responseHeaders[APIClientHeaders.xscAPIVersion] as? Int {
                    apiVersion = version
                }
                
                print("\(self.baseURL) API Version: \(apiVersion ?? -1)")
            } else {
                print("No Response Headers!")
            }
            
            completion(.success((result, apiVersion)))
        }
    }
}

// MARK: - Bots
public extension APIClient {
    private struct Bots: Codable {
        public var count: Int
        public var results: [XCSBot]
    }
    
    /// Requests the '`/bots`' endpoint from the Xcode Server API.
    func bots(_ completion: @escaping (Result<[XCSBot], Error>) -> Void) {
        get("bots") { (statusCode, headers, data: Bots?, error) in
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
    private struct Integrations: Codable {
        public var count: Int
        public var results: [XCSIntegration]
    }
    
    /// Requests the '`/bots/{id}/integrations`' endpoint from the Xcode Server API.
    func integrations(forBotWithIdentifier identifier: String, completion: @escaping (Result<[XCSIntegration], Error>) -> Void) {
        get("bots/\(identifier)/integrations") { (statusCode, headers, data: Integrations?, error) in
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
    private struct IntegrationCommits: Codable {
        public var count: Int
        public var results: [XCSCommit]
    }
    
    /// Requests the '`/integrations/{id}/commits`' endpoint from the Xcode Server API.
    func commits(forIntegrationWithIdentifier identifier: String, completion: @escaping (Result<[XCSCommit], Error>) -> Void) {
        get("integrations/\(identifier)/commits") { (statusCode, headers, data: IntegrationCommits?, error) in
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
    func coverage(forIntegrationWithIdentifier identifier: String, completion: @escaping (Result<XCSCoverageHierarchy?, Error>) -> Void) {
        get("integrations/\(identifier)/coverage") { (statusCode, headers, data: Data?, error) in
            guard statusCode != 401 else {
                completion(.failure(APIClientError.authorization))
                return
            }
            
            guard statusCode == 200 else {
                if statusCode == 404 {
                    // 404 is a valid response, no coverage data.
                    completion(.success(nil))
                } else {
                    completion(.failure(APIClientError.response(innerError: error)))
                }
                return
            }
            
            guard let result = data else {
                completion(.failure(APIClientError.serialization(innerError: error)))
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
            guard statusCode != 401 else {
                completion(.failure(APIClientError.authorization))
                return
            }
            
            guard statusCode == 200 else {
                completion(.failure(APIClientError.response(innerError: error)))
                return
            }
            
            var filename: String = "File.tar.gz"
            if let disposition = (headers?["Content-Disposition"] as? String)?.filenameFromContentDisposition() {
                filename = disposition
            }
            
            guard let result = data else {
                completion(.failure(APIClientError.serialization(innerError: error)))
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
