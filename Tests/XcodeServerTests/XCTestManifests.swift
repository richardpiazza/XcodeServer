import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(APIResponseTests.allTests),
        testCase(XcodeServerTests.allTests),
    ]
}
#endif
