import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(APIResponseTests.allTests),
        testCase(PersistentContainerTests.allTests),
        testCase(ServerWriteAndUpdateTests.allTests),
    ]
}
#endif
