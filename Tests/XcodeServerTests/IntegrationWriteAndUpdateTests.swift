import XCTest
@testable import XcodeServer
@testable import XcodeServerAPI
@testable import XcodeServerCoreData
@testable import XcodeServerPersistence

#if canImport(CoreData) && swift(>=5.3)
final class IntegrationWriteAndUpdateTests: XCTestCase {
    
    static var allTests = [
        ("testWriteIntegration", testWriteIntegration),
        ("testIntegrationCommitsAndIssues", testIntegrationCommitsAndIssues),
    ]
    
    private class Client: MockApiClient {
        override func getIntegration(_ id: XcodeServer.Integration.ID, queue: DispatchQueue?, completion: @escaping IntegrationResultHandler) {
            let queue = queue ?? returnQueue
            dispatchQueue.async {
                do {
                    let resource: XCSIntegration = try Bundle.module.decodeJson("integration", decoder: self.decoder)
                    let result = XcodeServer.Integration(resource, bot: nil, server: nil)
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
    
    private let client: MockApiClient = Client(serverId: .server1)
    private lazy var store: CoreDataStore = {
        do {
            return try CoreDataStore(model: .v1_0_0, persisted: false)
        } catch {
            preconditionFailure(error.localizedDescription)
        }
    }()
    
    var server: XcodeServer.Server!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        var server: XcodeServer.Server = .exampleServer
        server.bots.insert(.dynumite)
        
        let write = expectation(description: "Write Server & Bot")
        
        store.saveServer(server) { (result) in
            switch result {
            case .failure(let error):
                XCTFail(error.localizedDescription)
            case .success(let value):
                self.server = value
                write.fulfill()
            }
        }
        
        wait(for: [write], timeout: 1.0)
    }
    
    func testWriteIntegration() throws {
        var bot = try XCTUnwrap(server.bots.first(where: { $0.id == .bot1 }))
        var queryResult: XcodeServer.Integration?
        
        let queryIntegration = expectation(description: "Retrieve Integration")
        client.getIntegration(.integration1) { (result) in
            switch result {
            case .success(let value):
                queryResult = value
                queryIntegration.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [queryIntegration], timeout: 0.5)
        
        let integration = try XCTUnwrap(queryResult)
        bot.integrations.insert(integration)
        
        var updatedBot: XcodeServer.Bot?
        
        let saveBot = expectation(description: "Save Bot")
        store.saveBot(bot, forServer: .server1) { (result) in
            switch result {
            case .success(let value):
                updatedBot = value
                saveBot.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [saveBot], timeout: 0.5)
        
        // Evaluate Persisted Bot
        let _bot = try XCTUnwrap(updatedBot)
        let _integration = try XCTUnwrap(_bot.integrations.first(where: { $0.id == .integration1 }))
        try verifyDynumite24(_integration)
        try verifyDynumiteAssets(_integration)
    }
    
    func testIntegrationCommitsAndIssues() throws {
        var bot = try XCTUnwrap(server.bots.first(where: { $0.id == .bot1 }))
        bot.integrations.insert(.dynumite24)
        
        let saveBot = expectation(description: "Save Bot")
        store.saveBot(bot, forServer: .server1) { (result) in
            switch result {
            case .success:
                saveBot.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [saveBot], timeout: 0.5)
        
        var _integration: XcodeServer.Integration?
        let saveIntegration = expectation(description: "Save Integration")
        store.saveIntegration(.dynumite24, forBot: bot.id) { (result) in
            switch result {
            case .success(let value):
                _integration = value
                saveIntegration.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [saveIntegration], timeout: 0.5)
        
        let integration = try XCTUnwrap(_integration)
        try verifyDynumiteIssues(integration)
        try verifyDynumiteCommits(integration)
    }
}

extension IntegrationWriteAndUpdateTests {
    
    private func verifyDynumite24(_ integration: XcodeServer.Integration) throws {
        var components = DateComponents(calendar: nil, timeZone: nil, era: nil, year: 2020, month: 7, day: 13, hour: 12, minute: 27, second: 49, nanosecond: 342, weekday: nil, weekdayOrdinal: nil, quarter: nil, weekOfMonth: nil, weekOfYear: nil, yearForWeekOfYear: nil)
        var componentsDate: Date = try XCTUnwrap(Calendar.current.date(from: components))
        var date: Date
        
        XCTAssertEqual(integration.number, 24)
        XCTAssertEqual(integration.step, .completed)
        XCTAssertEqual(integration.shouldClean, false)
        date = try XCTUnwrap(integration.queued)
        XCTAssertEqual(Calendar.current.compare(date, to: componentsDate, toGranularity: .second), .orderedSame)
        components.nanosecond = 925
        componentsDate = try XCTUnwrap(Calendar.current.date(from: components))
        date = try XCTUnwrap(integration.started)
        XCTAssertEqual(Calendar.current.compare(date, to: componentsDate, toGranularity: .second), .orderedSame)
        components.minute = 28
        components.second = 0
        components.nanosecond = 066
        componentsDate = try XCTUnwrap(Calendar.current.date(from: components))
        date = try XCTUnwrap(integration.ended)
        XCTAssertEqual(Calendar.current.compare(date, to: componentsDate, toGranularity: .second), .orderedSame)
        XCTAssertEqual(integration.duration, 10.141)
        XCTAssertEqual(integration.result, .triggerError)
        XCTAssertEqual(integration.successStreak, 0)
        XCTAssertEqual(integration.codeCoverage, 0)
        XCTAssertEqual(integration.coverageDelta, 0)
    }
    
    private func verifyDynumiteAssets(_ integration: XcodeServer.Integration) throws {
        let assets = try XCTUnwrap(integration.assets)
        
        XCTAssertEqual(assets.sourceControlLog.size, 2752)
        XCTAssertEqual(assets.sourceControlLog.fileName, "sourceControl.log")
        XCTAssertEqual(assets.sourceControlLog.allowAnonymousAccess, false)
        XCTAssertEqual(assets.sourceControlLog.relativePath, "705d82e27dbb120dddc09af79100116b-Dynumite macOS/24/sourceControl.log")
        
        XCTAssertEqual(assets.buildServiceLog.size, 3610)
        XCTAssertEqual(assets.buildServiceLog.fileName, "buildService.log")
        XCTAssertEqual(assets.buildServiceLog.allowAnonymousAccess, false)
        XCTAssertEqual(assets.buildServiceLog.relativePath, "705d82e27dbb120dddc09af79100116b-Dynumite macOS/24/buildService.log")
        
        XCTAssertEqual(assets.triggerAssets.count, 2)
        let log0 = try XCTUnwrap(assets.triggerAssets.first(where: { $0.fileName.contains("before-0") }))
        XCTAssertEqual(log0.size, 122)
        XCTAssertEqual(log0.fileName, "trigger-before-0.log")
        XCTAssertEqual(log0.allowAnonymousAccess, false)
        XCTAssertEqual(log0.triggerName, "GIT Configuration")
        XCTAssertEqual(log0.relativePath, "705d82e27dbb120dddc09af79100116b-Dynumite macOS/24/trigger-before-0.log")
        
        let log1 = try XCTUnwrap(assets.triggerAssets.first(where: { $0.fileName.contains("before-1") }))
        XCTAssertEqual(log1.size, 769)
        XCTAssertEqual(log1.fileName, "trigger-before-1.log")
        XCTAssertEqual(log1.allowAnonymousAccess, false)
        XCTAssertEqual(log1.triggerName, "Tag Repository")
        XCTAssertEqual(log1.relativePath, "705d82e27dbb120dddc09af79100116b-Dynumite macOS/24/trigger-before-1.log")
    }
    
    private func verifyDynumiteIssues(_ integration: XcodeServer.Integration) throws {
        let catalog = try XCTUnwrap(integration.issues)
        XCTAssertEqual(catalog.buildServiceErrors.count, 1)
    }
    
    private func verifyDynumiteCommits(_ integration: XcodeServer.Integration) throws {
        let commits = try XCTUnwrap(integration.commits)
        XCTAssertEqual(commits.count, 8)
    }
}

private extension XcodeServer.Server {
    static let exampleServer: Self = {
        var server = XcodeServer.Server(id: .server1)
        server.version.app = .v2_0
        server.version.api = .v19
        server.version.macOSVersion = "11.0"
        server.version.xcodeAppVersion = "12.0"
        return server
    }()
}

private extension XcodeServer.Bot {
    static let dynumite: Self = {
        let _bot: XCSBot
        do {
            #if swift(>=5.3)
            _bot = try Bundle.module.decodeJson("bot")
            #else
            _bot = try botJson.decodeMultiline()
            #endif
        } catch {
            preconditionFailure(error.localizedDescription)
        }
        
        return XcodeServer.Bot(_bot, server: Server.exampleServer.id)
    }()
}

private extension XcodeServer.Integration {
    static let dynumite24: Self = {
        struct Commits: Decodable {
            let count: Int
            let results: [XCSCommit]
        }
        
        let _integration: XCSIntegration
        let issues: XCSIssues
        let commits: Commits
        var integration: XcodeServer.Integration
        do {
            #if swift(>=5.3)
            _integration = try Bundle.module.decodeJson("integration", decoder: XcodeServerAPI.APIClient.jsonDecoder)
            issues = try Bundle.module.decodeJson("issues")
            commits = try Bundle.module.decodeJson("commits", decoder: XcodeServerAPI.APIClient.jsonDecoder)
            #else
            _integration = try integrationJson.decodeMultiline(decoder: XcodeServerAPI.APIClient.jsonDecoder)
            issues = try issuesJson.decodeMultiline(decoder: XcodeServerAPI.APIClient.jsonDecoder)
            commits = try commitsJson.decodeMultiline(decoder: XcodeServerAPI.APIClient.jsonDecoder)
            #endif
        } catch {
            preconditionFailure(error.localizedDescription)
        }
        
        integration = XcodeServer.Integration(_integration, bot: XcodeServer.Bot.dynumite.id, server: nil)
        integration.issues = IssueCatalog(issues, integration: integration.id)
        integration.commits = Set(commits.results.commits(forIntegration: integration.id))
        return integration
    }()
}

private extension XcodeServer.Server.ID {
    static let server1: Self = "test.server.host"
}

private extension XcodeServer.Bot.ID {
    static let bot1: Self = "705d82e27dbb120dddc09af79100116b"
}

private extension XcodeServer.Integration.ID {
    static let integration1: Self = "2ce4a2fd2f57d53039edddc51e0009cf"
}
#endif
