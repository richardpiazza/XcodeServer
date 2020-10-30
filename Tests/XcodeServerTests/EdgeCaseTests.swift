import XCTest
@testable import XcodeServer
@testable import XcodeServerAPI
@testable import XcodeServerCoreData

#if canImport(CoreData)
final class EdgeCaseTests: XCTestCase {
    
    static var allTests = [
        ("testIntegrationCommitRemoteId", testIntegrationCommitRemoteId),
    ]
    
    private lazy var persistedStore: CoreDataStore = {
        return CoreDataStore(model: .v1_0_0, persisted: false)
    }()
    
    private lazy var client: MockApiClient = {
        return MockApiClient(serverId: .example)
    }()
    
    func testIntegrationCommitRemoteId() throws {
        var retrievedCommits: [SourceControl.Commit]?
        
        let query = expectation(description: "Retrieve Commits")
        client.getCommitsForIntegration(.structured18) { (result) in
            switch result {
            case .failure(let error):
                XCTFail(error.localizedDescription)
            case .success(let value):
                retrievedCommits = value
                query.fulfill()
            }
        }
        wait(for: [query], timeout: 0.5)
        
        let commits = try XCTUnwrap(retrievedCommits)
        XCTAssertEqual(commits.count, 15)
        commits.forEach { (commit) in
            XCTAssertNotNil(commit.remoteId)
        }
    }
}
#endif
