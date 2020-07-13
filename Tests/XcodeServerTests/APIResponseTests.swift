import XCTest
@testable import XcodeServerCommon
@testable import XcodeServerAPI

final class APIResponseTests: XCTestCase {
    
    static var allTests = [
        ("testVersions", testVersions),
    ]
    
    private let decoder = JSON.jsonDecoder
    
    func testVersions() throws {
        let url = try XCTUnwrap(Bundle.module.url(forResource: "versions", withExtension: "json"))
        let data = try Data(contentsOf: url)
        let versions = try decoder.decode(XCSVersion.self, from: data)
        
        XCTAssertEqual(versions._id, "bba9b6ff6d6f0899a63d1e347e000bd9")
        XCTAssertEqual(versions._rev, "334951-d449e2bcab5f311a242d44f285495a43")
        XCTAssertEqual(versions.docType, "version")
        XCTAssertEqual(versions.tinyID, "72EFA69")
        XCTAssertEqual(versions.os, "10.15.5 (19F101)")
        XCTAssertEqual(versions.xcode, "11.5 (11E608c)")
        XCTAssertEqual(versions.xcodeServer, "2.0")
        XCTAssertEqual(versions.server, "5.7.1 (18S1178)")
    }
    
    func testBots() throws {
        struct Bots: Decodable {
            let count: Int
            let results: [XCSBot]
        }
        
        let url = try XCTUnwrap(Bundle.module.url(forResource: "bots", withExtension: "json"))
        let data = try Data(contentsOf: url)
        let bots = try decoder.decode(Bots.self, from: data)
        
        XCTAssertEqual(bots.count, 7)
        XCTAssertEqual(bots.results.count, 7)
    }
    
    func testBot() throws {
        let url = try XCTUnwrap(Bundle.module.url(forResource: "bot", withExtension: "json"))
        let data = try Data(contentsOf: url)
        let bot = try decoder.decode(XCSBot.self, from: data)
        
        XCTAssertEqual(bot.identifier, "705d82e27dbb120dddc09af79100116b")
    }
    
    func testStats() throws {
        let url = try XCTUnwrap(Bundle.module.url(forResource: "stats", withExtension: "json"))
        let data = try Data(contentsOf: url)
        let stats = try decoder.decode(XCSStats.self, from: data)
        
        XCTAssertNotNil(stats.lastCleanIntegration)
    }
    
    func testIntegrations() throws {
        struct Integrations: Decodable {
            let count: Int
            let results: [XCSIntegration]
        }
        
        let url = try XCTUnwrap(Bundle.module.url(forResource: "integrations", withExtension: "json"))
        let data = try Data(contentsOf: url)
        let integrations = try decoder.decode(Integrations.self, from: data)
        
        XCTAssertEqual(integrations.count, 4)
        XCTAssertEqual(integrations.results.count, 4)
    }
    
    func testIntegration() throws {
        let url = try XCTUnwrap(Bundle.module.url(forResource: "integration", withExtension: "json"))
        let data = try Data(contentsOf: url)
        let integration = try decoder.decode(XCSIntegration.self, from: data)
        
        XCTAssertEqual(integration.identifier, "2ce4a2fd2f57d53039edddc51e0009cf")
    }
    
    func testRunIntegration() throws {
        let url = try XCTUnwrap(Bundle.module.url(forResource: "run-integration", withExtension: "json"))
        let data = try Data(contentsOf: url)
        let integration = try decoder.decode(XCSIntegration.self, from: data)
        
        XCTAssertEqual(integration.identifier, "2ce4a2fd2f57d53039edddc51e0009cf")
    }
    
    func testIssues() throws {
        let url = try XCTUnwrap(Bundle.module.url(forResource: "issues", withExtension: "json"))
        let data = try Data(contentsOf: url)
        let issues = try decoder.decode(XCSIssues.self, from: data)
        
        XCTAssertEqual(issues.triggerErrors?.count, 1)
    }
    
    func testCommits() throws {
        struct Commits: Decodable {
            let count: Int
            let results: [XCSCommit]
        }
        
        let url = try XCTUnwrap(Bundle.module.url(forResource: "commits", withExtension: "json"))
        let data = try Data(contentsOf: url)
        let commits = try decoder.decode(Commits.self, from: data)
        
        XCTAssertEqual(commits.count, 1)
        XCTAssertEqual(commits.results.count, 1)
    }
}
