import XCTest
@testable import XcodeServer
@testable import XcodeServerAPI
@testable import XcodeServerCoreData

#if canImport(CoreData)
final class EdgeCaseTests: XCTestCase {
    
    private class Client: MockApiClient {
        override func commits(forIntegration id: XcodeServer.Integration.ID) async throws -> [SourceControl.Commit] {
            let resource: XCSResults<XCSCommit> = try Bundle.module.decodeJson("structured18_commits", decoder: self.decoder)
            return resource.results.commits(forIntegration: id)
        }
    }
    
    private let client: MockApiClient = Client(serverId: .server1)
    private lazy var store: CoreDataStore = {
        do {
            return try CoreDataStore(model: .v1_0_0, persistence: .memory)
        } catch {
            preconditionFailure(error.localizedDescription)
        }
    }()
    
    func testIntegrationCommitRemoteId() throws {
        var retrievedCommits: [SourceControl.Commit]?
        
        let query = expectation(description: "Retrieve Commits")
        client.commits(forIntegration: .integration1) { (result) in
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

private extension XcodeServer.Server.ID {
    static let server1: Self = "test.server.host"
}

private extension XcodeServer.Integration.ID {
    static let integration1: Self = "4dce4862459fab67e33ff9cae7004b04"
}
#endif
