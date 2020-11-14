#if !canImport(ObjectiveC) && canImport(AsyncHTTPClient)
import Foundation
import Dispatch
import AsyncHTTPClient
import NIO
import NIOHTTP1
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

public class APIClient: XCSClient {
    
    private static var _eventLoopGroup: EventLoopGroup?
    
    private let client: HTTPClient
     
    public override init(fqdn: String, dispatchQueue: DispatchQueue = .main, credentialDelegate: CredentialDelegate? = nil) throws {
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
        
        try super.init(fqdn: fqdn, dispatchQueue: dispatchQueue, credentialDelegate: credentialDelegate)
    }
    
    deinit {
        try? client.syncShutdown()
    }
    
    func request(method: HTTPMethod, path: String, queryItems: [URLQueryItem]?, data: Data?) throws -> HTTPClient.Request {
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
        
        var body: HTTPClient.Body?
        if let data = data {
            body = .data(data)
            headers.add(name: "Content-Length", value: "\(data.count)")
        }
        
        return try HTTPClient.Request(url: url, method: method, headers: headers, body: body)
    }
    
    public override func getPath(_ path: String, queryItems: [URLQueryItem]? = nil, completion: @escaping DataTaskCompletion) {
        do {
            let request = try self.request(method: .GET, path: path, queryItems: queryItems, data: nil)
            client.execute(request: request).whenComplete { (result) in
                switch result {
                case .failure(let error):
                    completion(0, nil, nil, error)
                case .success(let response):
                    var data: Data?
                    if let bytes = response.body {
                        var content = Data()
                        content.append(contentsOf: bytes.readableBytesView)
                        if content.count > 0 {
                            data = content
                        }
                    }
                    completion(Int(response.status.code), response.headers.dictionary, data, nil)
                }
            }
        } catch {
            completion(0, nil, nil, error)
        }
    }
    
    public override func putData(_ data: Data?, path: String, queryItems: [URLQueryItem]? = nil, completion: @escaping DataTaskCompletion) {
        do {
            let request = try self.request(method: .PUT, path: path, queryItems: queryItems, data: data)
            client.execute(request: request).whenComplete { (result) in
                switch result {
                case .failure(let error):
                    completion(0, nil, nil, error)
                case .success(let response):
                    var data: Data?
                    if let bytes = response.body {
                        var content = Data()
                        content.append(contentsOf: bytes.readableBytesView)
                        if content.count > 0 {
                            data = content
                        }
                    }
                    completion(Int(response.status.code), response.headers.dictionary, data, nil)
                }
            }
        } catch {
            completion(0, nil, nil, error)
        }
    }
    
    public override func postData(_ data: Data?, path: String, queryItems: [URLQueryItem]? = nil, completion: @escaping DataTaskCompletion) {
        do {
            let request = try self.request(method: .POST, path: path, queryItems: queryItems, data: data)
            client.execute(request: request).whenComplete { (result) in
                switch result {
                case .failure(let error):
                    completion(0, nil, nil, error)
                case .success(let response):
                    var data: Data?
                    if let bytes = response.body {
                        var content = Data()
                        content.append(contentsOf: bytes.readableBytesView)
                        if content.count > 0 {
                            data = content
                        }
                    }
                    completion(Int(response.status.code), response.headers.dictionary, data, nil)
                }
            }
        } catch {
            completion(0, nil, nil, error)
        }
    }
    
    public override func patchData(_ data: Data?, path: String, queryItems: [URLQueryItem]? = nil, completion: @escaping DataTaskCompletion) {
        do {
            let request = try self.request(method: .PATCH, path: path, queryItems: queryItems, data: data)
            client.execute(request: request).whenComplete { (result) in
                switch result {
                case .failure(let error):
                    completion(0, nil, nil, error)
                case .success(let response):
                    var data: Data?
                    if let bytes = response.body {
                        var content = Data()
                        content.append(contentsOf: bytes.readableBytesView)
                        if content.count > 0 {
                            data = content
                        }
                    }
                    completion(Int(response.status.code), response.headers.dictionary, data, nil)
                }
            }
        } catch {
            completion(0, nil, nil, error)
        }
    }
    
    public override func deletePath(_ path: String, queryItems: [URLQueryItem]? = nil, completion: @escaping DataTaskCompletion) {
        do {
            let request = try self.request(method: .DELETE, path: path, queryItems: queryItems, data: nil)
            client.execute(request: request).whenComplete { (result) in
                switch result {
                case .failure(let error):
                    completion(0, nil, nil, error)
                case .success(let response):
                    var data: Data?
                    if let bytes = response.body {
                        var content = Data()
                        content.append(contentsOf: bytes.readableBytesView)
                        if content.count > 0 {
                            data = content
                        }
                    }
                    completion(Int(response.status.code), response.headers.dictionary, data, nil)
                }
            }
        } catch {
            completion(0, nil, nil, error)
        }
    }
}

private extension HTTPHeaders {
    var dictionary: [String: String] {
        var output: [String: String] = [:]
        self.forEach { (key, value) in
            output[key] = value
        }
        return output
    }
}

private extension HTTPResponseStatus {
    static let unhandled: HTTPResponseStatus = .custom(code: 0, reasonPhrase: "Unknown Error / Unhandled Failure")
}
#endif
