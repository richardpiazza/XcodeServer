public extension Issue {
    
    enum Confidence: Int, Codable {
        case high = 0
        case low = 1
    }
}

@available(*, deprecated, renamed: "Issue.Confidence")
public typealias IssueConfidence = Issue.Confidence
