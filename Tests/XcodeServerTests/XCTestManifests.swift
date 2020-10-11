import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    var allTests: [XCTestCaseEntry] = []
    #if swift(>=5.3)
    allTests.append(testCase(APIResponseTests.allTests))
    #endif
    #if canImport(CoreData)
    allTests.append(testCase(BotWriteAndUpdateTests.allTests))
    allTests.append(testCase(IntegrationWriteAndUpdateTests.allTests))
    allTests.append(testCase(PersistentContainerTests.allTests))
    allTests.append(testCase(ServerWriteAndUpdateTests.allTests))
    #endif
    return allTests
}
#endif
