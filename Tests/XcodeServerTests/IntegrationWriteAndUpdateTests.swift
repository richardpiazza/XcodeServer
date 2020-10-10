import XCTest
@testable import XcodeServer
@testable import XcodeServerAPI
@testable import XcodeServerCoreData

#if canImport(CoreData)
final class IntegrationWriteAndUpdateTests: XCTestCase {
    
    private lazy var persistedStore: CoreDataStore = {
        return CoreDataStore(model: .v1_0_0, persisted: false)
    }()
    
    private lazy var client: MockApiClient = {
        return MockApiClient(serverId: .example)
    }()
    
    var api: IntegrationQueryable {
        return client
    }
    
    var store: (ServerPersistable & BotPersistable & IntegrationPersistable) {
        return persistedStore
    }
    
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
        var bot = try XCTUnwrap(server.bots.first(where: { $0.id == .dynumiteMacOS }))
        var queryResult: XcodeServer.Integration?
        
        let queryIntegration = expectation(description: "Retrieve Integration")
        api.getIntegration(.dynumite24) { (result) in
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
        store.saveBot(bot) { (result) in
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
        let _integration = try XCTUnwrap(_bot.integrations.first(where: { $0.id == .dynumite24 }))
        try verifyDynumite24(_integration)
        try verifyDynumiteAssets(_integration)
    }
    
    func testIntegrationCommitsAndIssues() throws {
        var bot = try XCTUnwrap(server.bots.first(where: { $0.id == .dynumiteMacOS }))
        bot.integrations.insert(.dynumite24)
        
        let saveBot = expectation(description: "Save Bot")
        store.saveBot(bot) { (result) in
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
        store.saveIntegration(.dynumite24) { (result) in
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
        var server = XcodeServer.Server(id: .example)
        server.version.app = .v2_0
        server.version.api = .v19
        server.version.macOSVersion = "11.0"
        server.version.xcodeAppVersion = "12.0"
        return server
    }()
}

private extension XcodeServer.Bot {
    static let dynumite: Self = {
        #if swift(>=5.3)
        do {
            let _bot: XCSBot = try Bundle.module.decodeJson("bot")
            return XcodeServer.Bot(_bot, server: Server.exampleServer.id)
        } catch {
            preconditionFailure(error.localizedDescription)
        }
        #else
        return XcodeServer.Bot(id: .dynumiteMacOS)
        #endif
    }()
}

private extension XcodeServer.Integration {
    static let dynumite24: Self = {
        struct Commits: Decodable {
            let count: Int
            let results: [XCSCommit]
        }
        #if swift(>=5.3)
        do {
            let _integration: XCSIntegration = try Bundle.module.decodeJson("integration", decoder: XcodeServerAPI.APIClient.jsonDecoder)
            let issues: XCSIssues = try Bundle.module.decodeJson("issues")
            let commits: Commits = try Bundle.module.decodeJson("commits", decoder: XcodeServerAPI.APIClient.jsonDecoder)
            var integration = XcodeServer.Integration(_integration, bot: XcodeServer.Bot.dynumite.id, server: nil)
            integration.issues = IssueCatalog(issues, integration: integration.id)
            var _commits: [SourceControl.Commit] = []
            commits.results.forEach { (commit) in
                commit.commits?.forEach({ (key, value) in
                    _commits.append(contentsOf: value.map({ SourceControl.Commit($0, remote: $0.repositoryID, integration: integration.id) }))
                })
            }
            integration.commits = Set(_commits)
            return integration
        } catch {
            preconditionFailure(error.localizedDescription)
        }
        #else
        return XcodeServer.Integration(id: .dynumite24)
        #endif
    }()
}
#endif
