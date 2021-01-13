import XCTest
@testable import XcodeServer
@testable import XcodeServerAPI
@testable import XcodeServerCoreData

#if canImport(CoreData) && swift(>=5.3)
final class IntegrationIssueImportTests: XCTestCase {
    
    static var allTests = [
        ("testIntegration1Decoding", testIntegration1Decoding),
        ("testIntegration2Decoding", testIntegration2Decoding),
        ("testIntegration3Decoding", testIntegration3Decoding),
        ("testIntegration1IssuesStorage", testIntegration1IssuesStorage),
        ("testIntegration2IssuesStorage", testIntegration2IssuesStorage),
        ("testIntegration3IssuesStorage", testIntegration3IssuesStorage),
    ]
    
    private class Client: MockApiClient {
        override func getIssuesForIntegration(_ id: XcodeServer.Integration.ID, queue: DispatchQueue?, completion: @escaping IssueCatalogResultHandler) {
            let queue = queue ?? returnQueue
            let json: String
            switch id {
            case .integration1: json = "12.1_Integration_1_Issues"
            case .integration2: json = "12.1_Integration_2_Issues"
            case .integration3: json = "12.1_Integration_3_Issues"
            default:
                queue.async {
                    completion(.failure(.message("Unhandled ID '\(id)'")))
                }
                return
            }
            
            do {
                let resource: XCSIssues = try Bundle.module.decodeJson(json, decoder: self.decoder)
                let result = XcodeServer.Integration.IssueCatalog(resource, integration: id)
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
    
    private let client: MockApiClient = Client(serverId: "test.server.host")
    private lazy var store: CoreDataStore = {
        do {
            return try CoreDataStore(model: .v1_0_0, persisted: false)
        } catch {
            preconditionFailure(error.localizedDescription)
        }
    }()
    
    private let integration1 = XcodeServer.Integration(id: .integration1)
    private let integration2 = XcodeServer.Integration(id: .integration2)
    private let integration3 = XcodeServer.Integration(id: .integration3)
    private lazy var bot: XcodeServer.Bot = {
        var bot = XcodeServer.Bot(id: "2911c1d6174047dcf2a52f464a0135f6")
        bot.integrations = [integration1, integration2, integration3]
        return bot
    }()
    private lazy var server: XcodeServer.Server = {
        var server = XcodeServer.Server(id: "test.server.host")
        server.bots = [bot]
        return server
    }()
    private var catalog1: XcodeServer.Integration.IssueCatalog!
    private var catalog2: XcodeServer.Integration.IssueCatalog!
    private var catalog3: XcodeServer.Integration.IssueCatalog!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        var _catalog: XcodeServer.Integration.IssueCatalog?
        var query = expectation(description: "Get Catalog")
        
        client.getIssuesForIntegration(.integration1) { (result) in
            switch result {
            case .success(let value):
                _catalog = value
                query.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [query], timeout: 1.0)
        
        catalog1 = try XCTUnwrap(_catalog)
        
        query = expectation(description: "Get Catalog")
        client.getIssuesForIntegration(.integration2) { (result) in
            switch result {
            case .success(let value):
                _catalog = value
                query.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [query], timeout: 1.0)
        
        catalog2 = try XCTUnwrap(_catalog)
        
        query = expectation(description: "Get Catalog")
        client.getIssuesForIntegration(.integration3) { (result) in
            switch result {
            case .success(let value):
                _catalog = value
                query.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [query], timeout: 1.0)
        
        catalog3 = try XCTUnwrap(_catalog)
        
        let write = expectation(description: "Store Server")
        store.saveServer(server) { (result) in
            switch result {
            case .success:
                write.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        wait(for: [write], timeout: 1.0)
    }
    
    func testIntegration1Decoding() throws {
        let catalog = try XCTUnwrap(catalog1)
        
        try validateCatalog1(catalog)
        
        let buildWarning = try XCTUnwrap(catalog.buildServiceWarnings.first)
        XCTAssertEqual(buildWarning.extendedType, "buildServiceWarning")
        XCTAssertTrue(buildWarning.commits.isEmpty)
        XCTAssertTrue(buildWarning.authors.isEmpty)
        
        let uncategorized = try XCTUnwrap(catalog.errors.freshIssues.first(where: { $0.id == "2911c1d6174047dcf2a52f464a018254" }))
        XCTAssertEqual(uncategorized.extendedType, "Uncategorized")
        XCTAssertEqual(uncategorized.commits.count, 1)
        XCTAssertEqual(uncategorized.authors.count, 1)
        
        let uncategorizedCommit = try XCTUnwrap(uncategorized.commits.first)
        XCTAssertEqual(uncategorizedCommit.id, "1f1454d0933626c856557e42f93e91589b12691f")
        XCTAssertEqual(uncategorizedCommit.remoteId, "6D9FFC92170BF5EE19CA25700175BFFFBA40751A")
        XCTAssertEqual(uncategorizedCommit.integrationId, "2911c1d6174047dcf2a52f464a013c88")
        XCTAssertEqual(uncategorizedCommit.message, "Removed HUD in favor of AlertActivityViewController;\nRemoved 'success streak' as it is no longer available through the API.\n")
        XCTAssertEqual(uncategorizedCommit.isMerge, "NO")
        XCTAssertEqual(uncategorizedCommit.contributor.name, "Richard Piazza")
        XCTAssertEqual(uncategorizedCommit.contributor.displayName, "Richard Piazza")
        XCTAssertEqual(uncategorizedCommit.contributor.emails, ["richard@richardpiazza.com"])
        
        
        let uncategorizedAuthor = try XCTUnwrap(uncategorized.authors.first)
        XCTAssertEqual(uncategorizedAuthor.remoteId, "6D9FFC92170BF5EE19CA25700175BFFFBA40751A")
        XCTAssertEqual(uncategorizedAuthor.commitId, "1f1454d0933626c856557e42f93e91589b12691f")
        XCTAssertEqual(uncategorizedAuthor.suspectStrategy.confidence, .low)
        XCTAssertEqual(uncategorizedAuthor.suspectStrategy.reliability, 30)
        XCTAssertEqual(uncategorizedAuthor.suspectStrategy.identificationStrategy, .multipleCommitsSingleUserInIntegration)
        
        let compile = try XCTUnwrap(catalog.errors.freshIssues.first(where: { $0.id == "2911c1d6174047dcf2a52f464a0185c8" }))
        XCTAssertEqual(compile.extendedType, "Swift Compiler Error")
        XCTAssertEqual(compile.commits.count, 1)
        XCTAssertEqual(compile.authors.count, 1)
        
        let compileCommit = try XCTUnwrap(compile.commits.first)
        XCTAssertEqual(compileCommit.id, "77e0dd5d1d8307fcf7a846410717ecd09c3c2d0e")
        XCTAssertEqual(compileCommit.remoteId, "6D9FFC92170BF5EE19CA25700175BFFFBA40751A")
        XCTAssertEqual(compileCommit.integrationId, "2911c1d6174047dcf2a52f464a013c88")
        XCTAssertEqual(compileCommit.message, "Value Semantics (#1)\n\nThis work focuses on removing the need to reference Core Data throughout the app. Using an updated XcodeServer framework, which helps to establish a unified model that can be used across all modules.")
        XCTAssertEqual(compileCommit.isMerge, "NO")
        XCTAssertEqual(compileCommit.contributor.name, "Richard Piazza")
        XCTAssertEqual(compileCommit.contributor.displayName, "Richard Piazza")
        XCTAssertEqual(compileCommit.contributor.emails, ["richard@richardpiazza.com"])
        
        
        let compileAuthor = try XCTUnwrap(compile.authors.first)
        XCTAssertEqual(compileAuthor.remoteId, "6D9FFC92170BF5EE19CA25700175BFFFBA40751A")
        XCTAssertEqual(compileAuthor.commitId, "77e0dd5d1d8307fcf7a846410717ecd09c3c2d0e")
        XCTAssertEqual(compileAuthor.suspectStrategy.confidence, .high)
        XCTAssertEqual(compileAuthor.suspectStrategy.reliability, 90)
        XCTAssertEqual(compileAuthor.suspectStrategy.identificationStrategy, .fileHasBeenModifiedByCommits)
    }
    
    func testIntegration2Decoding() throws {
        let catalog = try XCTUnwrap(catalog2)
        
        try validateCatalog2(catalog)
        
        let error = try XCTUnwrap(catalog.buildServiceErrors.first)
        XCTAssertEqual(error.extendedType, "buildServiceError")
        XCTAssertTrue(error.commits.isEmpty)
        XCTAssertTrue(error.authors.isEmpty)
    }
    
    func testIntegration3Decoding() throws {
        let catalog = try XCTUnwrap(catalog3)
        
        try validateCatalog3(catalog)
        
        let error = try XCTUnwrap(catalog.buildServiceErrors.first)
        XCTAssertEqual(error.extendedType, "buildServiceError")
        XCTAssertTrue(error.commits.isEmpty)
        XCTAssertTrue(error.authors.isEmpty)
    }
    
    func testIntegration1IssuesStorage() throws {
        let _issues = try XCTUnwrap(catalog1)
        var _catalog: XcodeServer.Integration.IssueCatalog?
        
        let write = expectation(description: "Save Catalog")
        
        store.saveIssues(_issues, forIntegration: .integration1) { (result) in
            switch result {
            case .success(let value):
                _catalog = value
                write.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        wait(for: [write], timeout: 1.0)
        
        let catalog = try XCTUnwrap(_catalog)
        
        try validateCatalog1(catalog)
    }
    
    func testIntegration2IssuesStorage() throws {
        let _issues = try XCTUnwrap(catalog2)
        var _catalog: XcodeServer.Integration.IssueCatalog?
        
        let write = expectation(description: "Save Catalog")
        
        store.saveIssues(_issues, forIntegration: .integration2) { (result) in
            switch result {
            case .success(let value):
                _catalog = value
                write.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        wait(for: [write], timeout: 1.0)
        
        let catalog = try XCTUnwrap(_catalog)
        
        try validateCatalog2(catalog)
    }
    
    func testIntegration3IssuesStorage() throws {
        let _issues = try XCTUnwrap(catalog3)
        var _catalog: XcodeServer.Integration.IssueCatalog?
        
        let write = expectation(description: "Save Catalog")
        
        store.saveIssues(_issues, forIntegration: .integration3) { (result) in
            switch result {
            case .success(let value):
                _catalog = value
                write.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        wait(for: [write], timeout: 1.0)
        
        let catalog = try XCTUnwrap(_catalog)
        
        try validateCatalog3(catalog)
    }
    
    private func validateCatalog1(_ catalog: XcodeServer.Integration.IssueCatalog) throws {
        XCTAssertEqual(catalog.buildServiceErrors.count, 0)
        XCTAssertEqual(catalog.buildServiceWarnings.count, 1)
        XCTAssertEqual(catalog.triggerErrors.count, 0)
        XCTAssertEqual(catalog.errors.unresolvedIssues.count, 0)
        XCTAssertEqual(catalog.errors.freshIssues.count, 2)
        XCTAssertEqual(catalog.errors.resolvedIssues.count, 0)
        XCTAssertEqual(catalog.errors.silencedIssues.count, 0)
        XCTAssertEqual(catalog.warnings.unresolvedIssues.count, 0)
        XCTAssertEqual(catalog.warnings.freshIssues.count, 0)
        XCTAssertEqual(catalog.warnings.resolvedIssues.count, 0)
        XCTAssertEqual(catalog.warnings.silencedIssues.count, 0)
        XCTAssertEqual(catalog.testFailures.unresolvedIssues.count, 0)
        XCTAssertEqual(catalog.testFailures.freshIssues.count, 0)
        XCTAssertEqual(catalog.testFailures.resolvedIssues.count, 0)
        XCTAssertEqual(catalog.testFailures.silencedIssues.count, 0)
        XCTAssertEqual(catalog.analyzerWarnings.unresolvedIssues.count, 0)
        XCTAssertEqual(catalog.analyzerWarnings.freshIssues.count, 0)
        XCTAssertEqual(catalog.analyzerWarnings.resolvedIssues.count, 0)
        XCTAssertEqual(catalog.analyzerWarnings.silencedIssues.count, 0)
        
        let buildWarning = try XCTUnwrap(catalog.buildServiceWarnings.first)
        XCTAssertEqual(buildWarning.id, "2911c1d6174047dcf2a52f464a019134")
        XCTAssertEqual(buildWarning.message, "An error occurred while building, so archiving was skipped.")
        XCTAssertEqual(buildWarning.type, .BuildServiceWarning)
        XCTAssertEqual(buildWarning.age, 0)
        XCTAssertEqual(buildWarning.status, .new)
        
        let uncategorized = try XCTUnwrap(catalog.errors.freshIssues.first(where: { $0.id == "2911c1d6174047dcf2a52f464a018254" }))
        XCTAssertEqual(uncategorized.message, "Command CompileSwift failed with a nonzero exit code")
        XCTAssertEqual(uncategorized.type, .error)
        XCTAssertEqual(uncategorized.age, 0)
        XCTAssertEqual(uncategorized.status, .new)
        
        let compile = try XCTUnwrap(catalog.errors.freshIssues.first(where: { $0.id == "2911c1d6174047dcf2a52f464a0185c8" }))
        XCTAssertEqual(compile.message, "Module 'Pocket_Bot' was not compiled for testing")
        XCTAssertEqual(compile.type, .error)
        XCTAssertEqual(compile.age, 0)
        XCTAssertEqual(compile.status, .new)
    }
    
    private func validateCatalog2(_ catalog: XcodeServer.Integration.IssueCatalog) throws {
        XCTAssertEqual(catalog.buildServiceErrors.count, 1)
        XCTAssertEqual(catalog.buildServiceWarnings.count, 0)
        XCTAssertEqual(catalog.triggerErrors.count, 0)
        XCTAssertEqual(catalog.errors.unresolvedIssues.count, 0)
        XCTAssertEqual(catalog.errors.freshIssues.count, 0)
        XCTAssertEqual(catalog.errors.resolvedIssues.count, 0)
        XCTAssertEqual(catalog.errors.silencedIssues.count, 0)
        XCTAssertEqual(catalog.warnings.unresolvedIssues.count, 0)
        XCTAssertEqual(catalog.warnings.freshIssues.count, 0)
        XCTAssertEqual(catalog.warnings.resolvedIssues.count, 0)
        XCTAssertEqual(catalog.warnings.silencedIssues.count, 0)
        XCTAssertEqual(catalog.testFailures.unresolvedIssues.count, 0)
        XCTAssertEqual(catalog.testFailures.freshIssues.count, 0)
        XCTAssertEqual(catalog.testFailures.resolvedIssues.count, 0)
        XCTAssertEqual(catalog.testFailures.silencedIssues.count, 0)
        XCTAssertEqual(catalog.analyzerWarnings.unresolvedIssues.count, 0)
        XCTAssertEqual(catalog.analyzerWarnings.freshIssues.count, 0)
        XCTAssertEqual(catalog.analyzerWarnings.resolvedIssues.count, 0)
        XCTAssertEqual(catalog.analyzerWarnings.silencedIssues.count, 0)
        
        let error = try XCTUnwrap(catalog.buildServiceErrors.first)
        XCTAssertEqual(error.id, "2911c1d6174047dcf2a52f464a020662")
        XCTAssertEqual(error.message, "Integration results could not be uploaded. Test attachments and integration logs may be unavailable for this integration.")
        XCTAssertEqual(error.type, .buildServiceError)
        XCTAssertEqual(error.age, 0)
        XCTAssertEqual(error.status, .new)
    }
    
    private func validateCatalog3(_ catalog: XcodeServer.Integration.IssueCatalog) throws {
        XCTAssertEqual(catalog.buildServiceErrors.count, 1)
        XCTAssertEqual(catalog.buildServiceWarnings.count, 0)
        XCTAssertEqual(catalog.triggerErrors.count, 0)
        XCTAssertEqual(catalog.errors.unresolvedIssues.count, 0)
        XCTAssertEqual(catalog.errors.freshIssues.count, 0)
        XCTAssertEqual(catalog.errors.resolvedIssues.count, 0)
        XCTAssertEqual(catalog.errors.silencedIssues.count, 0)
        XCTAssertEqual(catalog.warnings.unresolvedIssues.count, 0)
        XCTAssertEqual(catalog.warnings.freshIssues.count, 0)
        XCTAssertEqual(catalog.warnings.resolvedIssues.count, 0)
        XCTAssertEqual(catalog.warnings.silencedIssues.count, 0)
        XCTAssertEqual(catalog.testFailures.unresolvedIssues.count, 0)
        XCTAssertEqual(catalog.testFailures.freshIssues.count, 0)
        XCTAssertEqual(catalog.testFailures.resolvedIssues.count, 0)
        XCTAssertEqual(catalog.testFailures.silencedIssues.count, 0)
        XCTAssertEqual(catalog.analyzerWarnings.unresolvedIssues.count, 0)
        XCTAssertEqual(catalog.analyzerWarnings.freshIssues.count, 0)
        XCTAssertEqual(catalog.analyzerWarnings.resolvedIssues.count, 0)
        XCTAssertEqual(catalog.analyzerWarnings.silencedIssues.count, 0)
        
        let error = try XCTUnwrap(catalog.buildServiceErrors.first)
        XCTAssertEqual(error.id, "2911c1d6174047dcf2a52f464a07ca5a")
        XCTAssertEqual(error.message, "exportArchive: Found no compatible export methods for: <DVTFilePath:0x7f7fd0089470:'/Users/xcodeserver/Library/Caches/XCSBuilder/Integration-2911c1d6174047dcf2a52f464a020b89/Pocket Bot.xcarchive'>")
        XCTAssertEqual(error.type, .buildServiceError)
        XCTAssertEqual(error.age, 0)
        XCTAssertEqual(error.status, .new)
    }
}

private extension XcodeServer.Integration.ID {
    static let integration1: Self = "2911c1d6174047dcf2a52f464a013c88"
    static let integration2: Self = "2911c1d6174047dcf2a52f464a019ee9"
    static let integration3: Self = "2911c1d6174047dcf2a52f464a020b89"
}
#endif
