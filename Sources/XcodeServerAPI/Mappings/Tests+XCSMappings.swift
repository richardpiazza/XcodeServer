import XcodeServer

public extension Tests.Hierarchy {
    init(_ tests: XCSTests) {
        self.init()
        suites = tests.suites.map({ Tests.Suite($0) })
    }
}

public extension Tests.Suite {
    init(_ suite: XCSTests.XCSTestSuite) {
        self.init()
        name = suite.name
        classes = suite.classes.map({ Tests.Class($0) })
        aggregateResults = suite.aggregateResults
    }
}

public extension Tests.Class {
    init(_ `class`: XCSTests.XCSTestClass) {
        self.init()
        name = `class`.name
        methods = `class`.methods.map({ Tests.Method($0) })
        aggregateResults = `class`.aggregateResults
    }
}

public extension Tests.Method {
    init(_ method: XCSTests.XCSTestMethod) {
        self.init()
        name = method.name
        deviceResults = method.deviceResults
    }
}
