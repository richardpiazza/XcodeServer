import XCTest
@testable import XcodeServer
@testable import XcodeServerCoreData

final class BotWriteAndUpdateTests: XCTestCase {
    
    #if canImport(CoreData)
    private lazy var persistedStore: CoreDataStore = {
        return CoreDataStore(model: .v1_0_0, persisted: false)
    }()
    
    private lazy var client: MockApiClient = {
        return MockApiClient(serverId: .example)
    }()
    
    var api: BotQueryable {
        return client
    }
    
    var store: (ServerPersistable & ServerQueryable) {
        return persistedStore
    }
    #endif
    
    func testWriteBot() throws {
        #if canImport(CoreData)
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
        
        
        /*
         public var id: String
         public var name: String = ""
         public var version: Int = 0
         public var relativePathToProject: String = ""
         public var primaryRemoteIdentifier: String = ""
         public var remotes: Set<Remote> = []
         public var locations: [String : Location] = [:]
         public var authenticationStrategies: [String: AuthenticationStrategy] = [:]
         public var additionalValidationRemotes: Set<Remote> = []
         */
        
        /*
         // MARK: - Bot Blueprints
         public var sourceControlBlueprint: SourceControl.Blueprint?
         public var lastRevisionBlueprint: SourceControl.Blueprint?
         */
        
        #endif
    }
    
    func testUpdateBot() throws {
        
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
