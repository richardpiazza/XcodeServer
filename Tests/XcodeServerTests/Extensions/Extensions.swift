import XcodeServer
import Foundation

extension Data {
    var hexString: String {
        return self.map { String(format: "%02hhx", $0) }.joined()
    }
}

extension Bundle {
    func decodeJson<T: Decodable>(_ resource: String, decoder: JSONDecoder = .init()) throws -> T {
        guard let url = self.url(forResource: resource, withExtension: "json") else {
            throw CocoaError(.fileNoSuchFile)
        }
        
        let data = try Data(contentsOf: url)
        return try decoder.decode(T.self, from: data)
    }
}
