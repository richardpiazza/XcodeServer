import XCTest
@testable import XcodeServer
@testable import XcodeServerAPI

final class APIResponseTests: XCTestCase {
    
    static var allTests = [
        ("testVersions", testVersions),
        ("testBots", testBots),
        ("testBot", testBot),
        ("testStats", testStats),
        ("testIntegrations", testIntegrations),
        ("testIntegration", testIntegration),
        ("testRunIntegration", testRunIntegration),
        ("testIssues", testIssues),
        ("testCommits", testCommits),
    ]
    
    private let decoder = APIClient.jsonDecoder
    
    func testVersions() throws {
        #if swift(>=5.3)
        let url = try XCTUnwrap(Bundle.module.url(forResource: "versions", withExtension: "json"))
        let data = try Data(contentsOf: url)
        let versions = try decoder.decode(XCSVersion.self, from: data)
        
        XCTAssertEqual(versions._id, "bba9b6ff6d6f0899a63d1e347e000bd9")
        XCTAssertEqual(versions._rev, "334951-d449e2bcab5f311a242d44f285495a43")
        XCTAssertEqual(versions.docType, "version")
        XCTAssertEqual(versions.macOSVersion, "10.15.5 (19F101)")
        XCTAssertEqual(versions.xcodeAppVersion, "11.5 (11E608c)")
        XCTAssertEqual(versions.xcodeServerVersion, "2.0")
        XCTAssertEqual(versions.serverAppVersion, "5.7.1 (18S1178)")
        #endif
    }
    
    func testBots() throws {
        #if swift(>=5.3)
        struct Bots: Decodable {
            let count: Int
            let results: [XCSBot]
        }
        
        let url = try XCTUnwrap(Bundle.module.url(forResource: "bots", withExtension: "json"))
        let data = try Data(contentsOf: url)
        let bots = try decoder.decode(Bots.self, from: data)
        
        XCTAssertEqual(bots.count, 7)
        XCTAssertEqual(bots.results.count, 7)
        #endif
    }
    
    func testBot() throws {
        #if swift(>=5.3)
        let url = try XCTUnwrap(Bundle.module.url(forResource: "bot", withExtension: "json"))
        let data = try Data(contentsOf: url)
        let bot = try decoder.decode(XCSBot.self, from: data)
        
        XCTAssertEqual(bot.id, "705d82e27dbb120dddc09af79100116b")
        #endif
    }
    
    func testStats() throws {
        #if swift(>=5.3)
        let url = try XCTUnwrap(Bundle.module.url(forResource: "stats", withExtension: "json"))
        let data = try Data(contentsOf: url)
        let stats = try decoder.decode(XCSStats.self, from: data)
        
        XCTAssertNotNil(stats.lastCleanIntegration)
        #endif
    }
    
    func testIntegrations() throws {
        #if swift(>=5.3)
        struct Integrations: Decodable {
            let count: Int
            let results: [XCSIntegration]
        }
        
        let url = try XCTUnwrap(Bundle.module.url(forResource: "integrations", withExtension: "json"))
        let data = try Data(contentsOf: url)
        let integrations = try decoder.decode(Integrations.self, from: data)
        
        XCTAssertEqual(integrations.count, 4)
        XCTAssertEqual(integrations.results.count, 4)
        #endif
    }
    
    func testIntegration() throws {
        #if swift(>=5.3)
        let url = try XCTUnwrap(Bundle.module.url(forResource: "integration", withExtension: "json"))
        let data = try Data(contentsOf: url)
        let integration = try decoder.decode(XCSIntegration.self, from: data)
        
        XCTAssertEqual(integration.id, "2ce4a2fd2f57d53039edddc51e0009cf")
        #endif
    }
    
    func testRunIntegration() throws {
        #if swift(>=5.3)
        let url = try XCTUnwrap(Bundle.module.url(forResource: "run-integration", withExtension: "json"))
        let data = try Data(contentsOf: url)
        let integration = try decoder.decode(XCSIntegration.self, from: data)
        
        XCTAssertEqual(integration.id, "2ce4a2fd2f57d53039edddc51e0009cf")
        #endif
    }
    
    func testIssues() throws {
        #if swift(>=5.3)
        let url = try XCTUnwrap(Bundle.module.url(forResource: "issues", withExtension: "json"))
        let data = try Data(contentsOf: url)
        let issues = try decoder.decode(XCSIssues.self, from: data)
        
        XCTAssertEqual(issues.triggerErrors?.count, 1)
        #endif
    }
    
    func testCommits() throws {
        #if swift(>=5.3)
        struct Commits: Decodable {
            let count: Int
            let results: [XCSCommit]
        }
        
        let url = try XCTUnwrap(Bundle.module.url(forResource: "commits", withExtension: "json"))
        let data = try Data(contentsOf: url)
        let commits = try decoder.decode(Commits.self, from: data)
        
        XCTAssertEqual(commits.count, 1)
        XCTAssertEqual(commits.results.count, 1)
        #endif
    }
}
