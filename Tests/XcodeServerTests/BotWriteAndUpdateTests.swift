import XCTest
@testable import XcodeServer
@testable import XcodeServerAPI
@testable import XcodeServerCoreData

#if canImport(CoreData)
final class BotWriteAndUpdateTests: XCTestCase {
    
    static var allTests = [
        ("testWriteBot", testWriteBot),
        ("testUpdateBotStats", testUpdateBotStats),
    ]
    
    private lazy var persistedStore: CoreDataStore = {
        return CoreDataStore(model: .v1_0_0, persisted: false)
    }()
    
    private lazy var client: MockApiClient = {
        return MockApiClient(serverId: .example)
    }()
    
    var api: BotQueryable {
        return client
    }
    
    var store: (ServerPersistable & BotPersistable) {
        return persistedStore
    }
    
    func testWriteBot() throws {
        let saveServer = expectation(description: "Save Server")
        store.saveServer(.exampleServer) { (result) in
            switch result {
            case .success:
                saveServer.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [saveServer], timeout: 0.5)
        
        let queryBot = expectation(description: "Retrieve Bot")
        var bot: XcodeServer.Bot?
        api.getBot(.dynumiteMacOS) { (result) in
            switch result {
            case .success(let value):
                bot = value
                queryBot.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [queryBot], timeout: 0.5)
        
        let saveBot = expectation(description: "Save Bot")
        var updatedServer: XcodeServer.Server = .exampleServer
        let _bot = try XCTUnwrap(bot)
        updatedServer.bots.insert(_bot)
        var retrievedServer: XcodeServer.Server?
        store.saveServer(updatedServer) { (result) in
            switch result {
            case .success(let value):
                retrievedServer = value
                saveBot.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [saveBot], timeout: 0.5)
        
        // Evaluate retrieved server.
        let _retrievedServer = try XCTUnwrap(retrievedServer)
        let retrievedBot = try XCTUnwrap(_retrievedServer.bots.first)
        XCTAssertEqual(retrievedBot.id, .dynumiteMacOS)
        XCTAssertEqual(retrievedBot.name, "Dynumite macOS")
        XCTAssertEqual(retrievedBot.nextIntegrationNumber, 24)
        XCTAssertEqual(retrievedBot.type, 1)
        XCTAssertEqual(retrievedBot.requiresUpgrade, false)
        XCTAssertEqual(retrievedBot.serverId, .example)
//        XCTAssertEqual(retrievedBot.stats, XcodeServer.Bot.Stats())
        XCTAssertEqual(retrievedBot.integrations.count, 0)
        
        let config = retrievedBot.configuration
        XCTAssertEqual(config.schedule, .manual)
        XCTAssertEqual(config.periodicInterval, .none)
        XCTAssertEqual(config.weeklyScheduleDay, 0)
        XCTAssertEqual(config.hourOfIntegration, 0)
        XCTAssertEqual(config.minutesAfterHourToIntegrate, 0)
        XCTAssertEqual(config.schemeName, "Dynumite")
        XCTAssertEqual(config.cleaning, .weekly)
        XCTAssertEqual(config.disableAppThinning, false)
        XCTAssertEqual(config.coverage, .useSchemeSetting)
        XCTAssertEqual(config.useParallelDevices, false)
        XCTAssertEqual(config.performsArchive, true)
        XCTAssertEqual(config.performsAnalyze, true)
        XCTAssertEqual(config.performsTest, true)
        XCTAssertEqual(config.performsUpgradeIntegration, false)
        XCTAssertEqual(config.exportsProduct, true)
        XCTAssertEqual(config.runOnlyDisabledTests, false)
        XCTAssertEqual(config.buildArguments, [])
        XCTAssertEqual(config.environmentVariables, [:])
//        XCTAssertEqual(config.archiveExportOptions, XcodeServer.Bot.Configuration.ArchiveExport())
        XCTAssertEqual(config.provisioning.addMissingDevicesToTeams, true)
        XCTAssertEqual(config.provisioning.manageCertsAndProfiles, true)
        
        XCTAssertEqual(config.triggers.count, 2)
        let tag = try XCTUnwrap(config.triggers.first(where: { $0.name == "Tag Repository" }))
        XCTAssertEqual(tag.phase, .beforeIntegration)
        XCTAssertEqual(tag.type, .script)
        XCTAssertTrue(tag.scriptBody.contains("push origin tag"))
        XCTAssertEqual(tag.conditions.status, 2)
        XCTAssertEqual(tag.conditions.onAllIssuesResolved, false)
        XCTAssertEqual(tag.conditions.onWarnings, true)
        XCTAssertEqual(tag.conditions.onBuildErrors, true)
        XCTAssertEqual(tag.conditions.onAnalyzerWarnings, true)
        XCTAssertEqual(tag.conditions.onFailingTests, true)
        XCTAssertEqual(tag.conditions.onSuccess, true)
        
        let git = try XCTUnwrap(config.triggers.first(where: { $0.name == "GIT Configuration" }))
        XCTAssertEqual(git.phase, .beforeIntegration)
        XCTAssertEqual(git.type, .script)
        XCTAssertTrue(git.scriptBody.contains("Setting Git Global"))
        XCTAssertEqual(git.conditions.status, 2)
        XCTAssertEqual(git.conditions.onAllIssuesResolved, false)
        XCTAssertEqual(git.conditions.onWarnings, true)
        XCTAssertEqual(git.conditions.onBuildErrors, true)
        XCTAssertEqual(git.conditions.onAnalyzerWarnings, true)
        XCTAssertEqual(git.conditions.onFailingTests, true)
        XCTAssertEqual(git.conditions.onSuccess, true)
        
        let spec = config.deviceSpecification
        XCTAssertEqual(spec.devices, [])
        XCTAssertEqual(spec.filters.count, 1)
        
        let filter = try XCTUnwrap(spec.filters.first)
        XCTAssertEqual(filter.type, 0)
        XCTAssertEqual(filter.architecture, 1)
        XCTAssertEqual(filter.platform.id, "bba9b6ff6d6f0899a63d1e347e002e75")
        XCTAssertEqual(filter.platform.buildNumber, "16C58")
        XCTAssertEqual(filter.platform.displayName, "macOS")
        XCTAssertEqual(filter.platform.platformIdentifier, "com.apple.platform.macosx")
        XCTAssertEqual(filter.platform.version, "1.1")
        
        // currently empty as the core data entity structure doesn't allow for it.
        // but, the repository object should have been created.
        XCTAssertEqual(config.sourceControlBlueprint, SourceControl.Blueprint())
        let repository = try XCTUnwrap(persistedStore.persistentContainer.viewContext.repository(withIdentifier: "0430DC0FCD6EB7BC51C585D722CCD37A72BD7D71"))
        XCTAssertEqual(repository.identifier, "0430DC0FCD6EB7BC51C585D722CCD37A72BD7D71")
        XCTAssertEqual(repository.system, "com.apple.dt.Xcode.sourcecontrol.Git")
        XCTAssertEqual(repository.url, "bitbucket.org:richardpiazza/com.richardpiazza.dynumite.git")
        XCTAssertEqual(repository.branchIdentifier, "master")
        XCTAssertEqual(repository.branchOptions, 4)
        XCTAssertEqual(repository.locationType, "DVTSourceControlBranch")
    }
    
    func testUpdateBotStats() throws {
        var server: XcodeServer.Server = .exampleServer
        server.bots.insert(.dynumite)
        
        let saveServer = expectation(description: "Save Server")
        store.saveServer(server) { (result) in
            switch result {
            case .success(let value):
                server = value
                saveServer.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [saveServer], timeout: 0.5)
        
        var bot = try XCTUnwrap(server.bots.first)
        var _stats: XcodeServer.Bot.Stats?
        
        let getStats = expectation(description: "Get Stats")
        api.getStatsForBot(bot.id) { (result) in
            switch result {
            case .success(let value):
                _stats = value
                getStats.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [getStats], timeout: 0.5)
        
        bot.stats = try XCTUnwrap(_stats)
        
        let saveBot = expectation(description: "Save Bot")
        store.saveBot(bot) { (result) in
            switch result {
            case .success(let value):
                bot = value
                saveBot.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [saveBot], timeout: 0.5)
        
        let stats = bot.stats
        XCTAssertEqual(stats.successfulIntegrations, 2)
        XCTAssertEqual(stats.coverageDelta, 0)
        XCTAssertEqual(stats.testAdditionRate, 55)
        XCTAssertEqual(stats.commits, 7)
        XCTAssertEqual(stats.integrations, 4)
        XCTAssertEqual(stats.analysisWarnings.sum, 4.0)
        XCTAssertEqual(stats.analysisWarnings.count, 2)
        XCTAssertEqual(stats.analysisWarnings.min, 2.0)
        XCTAssertEqual(stats.analysisWarnings.max, 2.0)
        XCTAssertEqual(stats.analysisWarnings.average, 2.0)
        XCTAssertEqual(stats.analysisWarnings.standardDeviation, 100.0)
        XCTAssertEqual(stats.analysisWarnings.sumOfSquares, 0.0)
        XCTAssertEqual(stats.testFailures.sum, 0.0)
        XCTAssertEqual(stats.testFailures.count, 4)
        XCTAssertEqual(stats.testFailures.min, 0.0)
        XCTAssertEqual(stats.testFailures.max, 0.0)
        XCTAssertEqual(stats.testFailures.average, 0.0)
        XCTAssertEqual(stats.testFailures.standardDeviation, 0.0)
        XCTAssertEqual(stats.testFailures.sumOfSquares, 0.0)
        XCTAssertEqual(stats.errors.sum, 0.0)
        XCTAssertEqual(stats.errors.count, 4)
        XCTAssertEqual(stats.errors.min, 0.0)
        XCTAssertEqual(stats.errors.max, 0.0)
        XCTAssertEqual(stats.errors.average, 0.0)
        XCTAssertEqual(stats.errors.standardDeviation, 0.0)
        XCTAssertEqual(stats.errors.sumOfSquares, 0.0)
        XCTAssertEqual(stats.regressedPerformanceTests.sum, 0.0)
        XCTAssertEqual(stats.regressedPerformanceTests.count, 4)
        XCTAssertEqual(stats.regressedPerformanceTests.min, 0.0)
        XCTAssertEqual(stats.regressedPerformanceTests.max, 0.0)
        XCTAssertEqual(stats.regressedPerformanceTests.average, 0.0)
        XCTAssertEqual(stats.regressedPerformanceTests.standardDeviation, 0.0)
        XCTAssertEqual(stats.regressedPerformanceTests.sumOfSquares, 0.0)
        XCTAssertEqual(stats.warnings.sum, 4.0)
        XCTAssertEqual(stats.warnings.count, 4)
        XCTAssertEqual(stats.warnings.min, 0.0)
        XCTAssertEqual(stats.warnings.max, 2.0)
        XCTAssertEqual(stats.warnings.average, 1.0)
        XCTAssertEqual(stats.warnings.standardDeviation, 173.20508075688772)
        XCTAssertEqual(stats.warnings.sumOfSquares, 0.0)
        XCTAssertEqual(stats.improvedPerformanceTests.sum, 0.0)
        XCTAssertEqual(stats.improvedPerformanceTests.count, 4)
        XCTAssertEqual(stats.improvedPerformanceTests.min, 0.0)
        XCTAssertEqual(stats.improvedPerformanceTests.max, 0.0)
        XCTAssertEqual(stats.improvedPerformanceTests.average, 0.0)
        XCTAssertEqual(stats.improvedPerformanceTests.standardDeviation, 0.0)
        XCTAssertEqual(stats.improvedPerformanceTests.sumOfSquares, 0.0)
        XCTAssertEqual(stats.tests.sum, 187.0)
        XCTAssertEqual(stats.tests.count, 4)
        XCTAssertEqual(stats.tests.min, 44.0)
        XCTAssertEqual(stats.tests.max, 55.0)
        XCTAssertEqual(stats.tests.average, 46.75)
        XCTAssertEqual(stats.tests.standardDeviation, 173.20508075688775)
        XCTAssertEqual(stats.tests.sumOfSquares, 0.0)
        
        let cal = Calendar(identifier: .gregorian)
        let components: DateComponents = .init(calendar: nil, timeZone: nil, era: nil, year: 2020, month: 7, day: 1, hour: 14, minute: 3, second: 35, nanosecond: 260, weekday: nil, weekdayOrdinal: nil, quarter: nil, weekOfMonth: nil, weekOfYear: nil, yearForWeekOfYear: nil)
        let date: Date = cal.date(from: components)!
        
        let lastClean = try XCTUnwrap(stats.lastCleanIntegration)
        XCTAssertEqual(lastClean.id, "ce5f34cace5a2142835263cd2f210744")
        var compare = Calendar.current.compare(lastClean.ended!, to: date, toGranularity: .second)
        XCTAssertTrue(compare == .orderedSame)
        
        let bestStreak = try XCTUnwrap(stats.bestSuccessStreak)
        XCTAssertEqual(bestStreak.id, "ce5f34cace5a2142835263cd2f210744")
        XCTAssertEqual(bestStreak.successStreak, 2)
        compare = Calendar.current.compare(bestStreak.ended!, to: date, toGranularity: .second)
        XCTAssertTrue(compare == .orderedSame)
        /*
         public var sinceDate: Date = Date()
         */
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
        let _bot: XCSBot
        #if swift(>=5.3)
        do {
            _bot = try Bundle.module.decodeJson("bot")
        } catch {
            print(error)
            _bot = XCSBot()
        }
        #else
        _bot = XCSBot()
        #endif
        return XcodeServer.Bot(_bot, server: .dynumiteMacOS)
    }()
}
#endif
