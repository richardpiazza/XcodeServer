import Foundation

extension Data {
    var hexString: String {
        return self.map { String(format: "%02hhx", $0) }.joined()
    }
}
