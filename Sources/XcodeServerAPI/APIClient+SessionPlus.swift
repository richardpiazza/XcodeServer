#if canImport(ObjectiveC) && canImport(SessionPlus)
import Foundation
import SessionPlus

public class APIClient: XCSClient, HTTPClient, HTTPCodable {
    
    public var session: URLSession
    public var authorization: HTTP.Authorization?
    
    public override init(fqdn: String, dispatchQueue: DispatchQueue = .main, credentialDelegate: CredentialDelegate? = nil) throws {
        session = URLSession(configuration: URLSessionConfiguration.default, delegate: SelfSignedSessionDelegate(), delegateQueue: nil)
        try super.init(fqdn: fqdn, dispatchQueue: dispatchQueue, credentialDelegate: credentialDelegate)
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
        
        if let credentials = credentialDelegate?.credentials(for: url.host ?? "") {
            let auth: HTTP.Authorization = .basic(username: credentials.username, password: credentials.password)
            request.setValue(auth.headerValue, forHTTPHeader: HTTP.Header.authorization)
        }
        
        return request
    }
    
    public override func getPath(_ path: String, queryItems: [URLQueryItem]? = nil, completion: @escaping XCSClient.DataTaskCompletion) {
        self.get(path, queryItems: queryItems) { (statusCode, headers, data: Data?, error) in
            completion(statusCode, headers as? [String: String], data, error)
        }
    }
    
    public override func putData(_ data: Data?, path: String, queryItems: [URLQueryItem]? = nil, completion: @escaping XCSClient.DataTaskCompletion) {
        self.put(data, path: path, queryItems: queryItems) { (statusCode, headers, data: Data?, error) in
            completion(statusCode, headers as? [String: String], data, error)
        }
    }
    
    public override func postData(_ data: Data?, path: String, queryItems: [URLQueryItem]? = nil, completion: @escaping XCSClient.DataTaskCompletion) {
        self.post(data, path: path, queryItems: queryItems) { (statusCode, headers, data: Data?, error) in
            completion(statusCode, headers as? [String: String], data, error)
        }
    }
    
    public override func patchData(_ data: Data?, path: String, queryItems: [URLQueryItem]? = nil, completion: @escaping XCSClient.DataTaskCompletion) {
        self.patch(data, path: path, queryItems: queryItems) { (statusCode, headers, data: Data?, error) in
            completion(statusCode, headers as? [String: String], data, error)
        }
    }
    
    public override func deletePath(_ path: String, queryItems: [URLQueryItem]? = nil, completion: @escaping XCSClient.DataTaskCompletion) {
        self.delete(path, queryItems: queryItems) { (statusCode, headers, data: Data?, error) in
            completion(statusCode, headers as? [String: String], data, error)
        }
    }
}
#endif
