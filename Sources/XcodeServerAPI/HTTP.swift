import Foundation

/// A Collection of methods/headers/values/types used during basic HTTP interactions.
public struct HTTP {
    
    /// Desired action to be performed for a given resource.
    ///
    /// Although they can also be nouns, these request methods are sometimes referred as HTTP verbs.
    @available(*, deprecated, message: "See: NIOHTTP1.HTTPTypes.HTTPMethod")
    public enum RequestMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case patch = "PATCH"
        case delete = "DELETE"
        
        public var description: String {
            switch self {
            case .get:
                return "The GET method requests a representation of the specified resource. Requests using GET should only retrieve data."
            case .put:
                return "The PUT method replaces all current representations of the target resource with the request payload."
            case .post:
                return "The POST method is used to submit an entity to the specified resource, often causing a change in state or side effects on the server."
            case .patch:
                return "The PATCH method is used to apply partial modifications to a resource."
            case .delete:
                return "The DELETE method deletes the specified resource."
            }
        }
    }
    
    /// HTTP Headers as provided from HTTPURLResponse
    @available(*, deprecated, message: "See: NIOHTTP1.HTTPTypes.HTTPHeaders")
    public typealias Headers = [AnyHashable : Any]
    
    /// Command HTTP Header
    @available(*, deprecated, message: "See: NIOHTTP1.HTTPTypes.HTTPMethod")
    public enum Header: String {
        case accept = "Accept"
        case authorization = "Authorization"
        case contentLength = "Content-Length"
        case contentMD5 = "Content-MD5"
        case contentType = "Content-Type"
        case date = "Date"
        
        public var description: String {
            switch self {
            case .accept:
                return "The Accept request HTTP header advertises which content types, expressed as MIME types, the client is able to understand."
            case .authorization:
                return "The HTTP Authorization request header contains the credentials to authenticate a user agent with a server, usually after the server has responded with a 401 Unauthorized status and the WWW-Authenticate header."
            case .contentLength:
                return "The Content-Length entity header is indicating the size of the entity-body, in bytes, sent to the recipient."
            case .contentType:
                return "The Content-Type entity header is used to indicate the media type of the resource."
            case .contentMD5:
                return "The Content-MD5 header, may be used as a message integrity check (MIC), to verify that the decoded data are the same data that were initially sent."
            case .date:
                return "The Date general HTTP header contains the date and time at which the message was originated."
            }
        }
        
        /// HTTP Header date formatter; RFC1123
        public static var dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE',' dd MMM yyyy HH':'mm':'ss 'GMT'"
            formatter.timeZone = TimeZone(identifier: "GMT")!
            formatter.locale = Locale(identifier: "en_US_POSIX")
            return formatter
        }()
    }
    
    /// MIME Types used in the API
    @available(*, deprecated)
    public enum MIMEType: String {
        case applicationJson = "application/json"
    }
    
    /// Authorization schemes used in the API
    @available(*, deprecated, message: "See: AsyncHTTPClient.HTTPHandler.Authorization")
    public enum Authorization {
        case basic(username: String, password: String?)
        case bearer(token: String)
        case custom(headerField: String, headerValue: String)
        
        public var headerValue: String {
            switch self {
            case .basic(let username, let password):
                let pwd = password ?? ""
                guard let data = "\(username):\(pwd)".data(using: .utf8) else {
                    return ""
                }
                
                let base64 = data.base64EncodedString(options: [])
                
                return "Basic \(base64)"
            case .bearer(let token):
                return "Bearer \(token)"
            case .custom(let headerField, let headerValue):
                return "\(headerField) \(headerValue))"
            }
        }
    }
    
    /// General errors that may be emitted during HTTP Request/Response handling.
    @available(*, deprecated)
    public enum Error: Swift.Error, LocalizedError {
        case invalidURL
        case invalidRequest
        case invalidResponse
        
        public var errorDescription: String? {
            switch self {
            case .invalidURL:
                return "Invalid URL: URL is nil or invalid."
            case .invalidRequest:
                return "Invalid URL Request: URLRequest is nil or invalid."
            case .invalidResponse:
                return "Invalid URL Response: HTTPURLResponse is nil or invalid."
            }
        }
    }
}
