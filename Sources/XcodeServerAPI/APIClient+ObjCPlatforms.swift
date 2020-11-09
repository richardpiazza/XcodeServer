#if canImport(ObjectiveC)
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
}
#endif
