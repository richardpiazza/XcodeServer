import Foundation

/// The Xcode Server API version.
///
/// Identified in HTTP headers under the key '**x-xcsapiversion**'.
public enum APIVersion: Int, Codable {
    case v19 = 19
}

/// MacOS Operation System Version
public enum MacOSVersion: String, Codable {
    case v10_14_6 = "10.14.6 (18G95)"
    case v10_15 = "10.15 (19A558d)"
}

/// MacOS Operation Server App Version
public enum MacOSServerVersion: String, Codable {
    case v5_7_1 = "5.7.1 (18S1178)"
    case v5_8 = "5.8"
}

/// Xcode.app Version
public enum XcodeVersion: String, Codable {
    case v_10_3 = "10.3 (10G8)"
    case v_11_0 = "11.0 (11A419c)"
}

/// Xcode.app Server Version
public enum XcodeServerVersion: String, Codable {
    case v_2_0 = "2.0"
}
