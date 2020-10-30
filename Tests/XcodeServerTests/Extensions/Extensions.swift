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

extension String {
    func decodeMultiline<T: Decodable>(decoder: JSONDecoder = .init()) throws -> T {
        guard let data = self.data(using: .utf8) else {
            throw CocoaError(.coderReadCorrupt)
        }
        
        return try decoder.decode(T.self, from: data)
    }
}
