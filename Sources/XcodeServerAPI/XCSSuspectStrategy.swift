import XcodeServerCommon

public struct XCSSuspectStrategy: Codable {
    public var confidence: IssueConfidence?
    public var reliability: Int?
    public var identificationStrategy: IssueIdentificationStrategy?
}

// MARK: - Equatable
extension XCSSuspectStrategy: Equatable {
}

// MARK: - Hashable
extension XCSSuspectStrategy: Hashable {
}
