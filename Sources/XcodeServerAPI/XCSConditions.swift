import Foundation

public struct XCSConditions: Codable {
    public var status: Int?
    public var onAllIssuesResolved: Bool?
    public var onWarnings: Bool?
    public var onBuildErrors: Bool?
    public var onAnalyzerWarnings: Bool?
    public var onFailingTests: Bool?
    public var onSuccess: Bool?
}
