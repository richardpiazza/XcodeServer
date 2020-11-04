import XCTest
@testable import XcodeServer
@testable import XcodeServerAPI
@testable import XcodeServerCoreData

#if canImport(CoreData) && swift(>=5.3)
final class EdgeCaseTests: XCTestCase {
    
    static var allTests = [
        ("testIntegrationCommitRemoteId", testIntegrationCommitRemoteId),
    ]
    
    private class Client: MockApiClient {
        override func getCommitsForIntegration(_ id: XcodeServer.Integration.ID, queue: DispatchQueue?, completion: @escaping CommitsResultHandler) {
            let queue = queue ?? returnQueue
            dispatchQueue.async {
                do {
                    let resource: XCSResults<XCSCommit> = try Bundle.module.decodeJson("structured18_commits", decoder: self.decoder)
                    let result: [SourceControl.Commit] = resource.results.commits(forIntegration: id)
                    queue.async {
                        completion(.success(result))
                    }
                } catch {
                    queue.async {
                        completion(.failure(.error(error)))
                    }
                }
            }
        }
    }
    
    private let store: CoreDataStore = CoreDataStore(model: .v1_0_0, persisted: false)
    private let client: MockApiClient = Client(serverId: .server1)
    
    func testIntegrationCommitRemoteId() throws {
        var retrievedCommits: [SourceControl.Commit]?
        
        let query = expectation(description: "Retrieve Commits")
        client.getCommitsForIntegration(.integration1) { (result) in
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
