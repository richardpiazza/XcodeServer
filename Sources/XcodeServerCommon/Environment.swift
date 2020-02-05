import Foundation

/// The Xcode Server API version.
///
/// Identified in HTTP headers under the key '**x-xcsapiversion**'.
public enum APIVersion: Int, Codable {
    case v19 = 19
}

/// Xcode.app Server Version
public enum XcodeServerVersion: String, Codable {
    case v2_0 = "2.0"
}
