import XCTest
@testable import XcodeServer
@testable import XcodeServerCoreData
@testable import XcodeServerPersistence
@testable import XcodeServerModel_1_0_0

#if canImport(CoreData)
final class ServerWriteAndUpdateTests: XCTestCase {
    
    static var allTests = [
        ("testWriteServer", testWriteServer),
        ("testUpdateServer", testUpdateServer),
    ]
    
    lazy var persistedStore: CoreDataStore = {
        do {
            return try CoreDataStore(model: .v1_0_0, persisted: false)
        } catch {
            preconditionFailure(error.localizedDescription)
        }
    }()
    
    var store: (ServerPersistable & ServerQueryable) {
        return persistedStore
    }
    
    func testWriteServer() throws {
        let server: XcodeServer.Server = .testServer
        let complete = expectation(description: "complete")
        
        store.saveServer(server) { (result) in
            switch result {
            case .failure(let error):
                XCTFail(error.localizedDescription)
            case .success(let mappedValue):
                XCTAssertEqual(mappedValue.id, .server1)
                XCTAssertEqual(mappedValue.version.api, .v19)
                XCTAssertEqual(mappedValue.version.app, .v2_0)
                XCTAssertEqual(mappedValue.version.macOSVersion, "10.15")
                XCTAssertEqual(mappedValue.version.xcodeAppVersion, "11.6")
                XCTAssertEqual(mappedValue.url, URL(string: "https://xcodeserver.apple.com:20343/api"))
                
                guard let server1 = self.persistedStore.server1 else {
                    XCTFail("No persisted 'Server' with FQDN '\(server.id)'.")
                    return
                }
                
                XCTAssertEqual(server1.fqdn, server.id)
                XCTAssertEqual(server1.apiVersion, 19)
                XCTAssertEqual(server1.xcodeServer, "2.0")
                XCTAssertEqual(server1.os, "10.15")
                XCTAssertEqual(server1.xcode, "11.6")
                XCTAssertEqual(server1.apiURL, URL(string: "https://xcodeserver.apple.com:20343/api"))
                
                complete.fulfill()
            }
        }
        
        wait(for: [complete], timeout: 0.5)
    }
    
    func testUpdateServer() {
        let server: XcodeServer.Server = .testServer
        let complete = expectation(description: "complete")
        
        store.saveServer(server) { (result) in
            switch result {
            case .failure(let error):
                XCTFail(error.localizedDescription)
            case .success:
                guard let initialState = self.persistedStore.server1 else {
                    XCTFail()
                    return
                }
                
                XCTAssertEqual(initialState.os, "10.15")
                XCTAssertEqual(initialState.xcode, "11.6")
                
                self.store.saveServer(.updateServer) { (updateResult) in
                    switch updateResult {
                    case .failure(let error):
                        XCTFail(error.localizedDescription)
                    case .success(let mappedValue):
                        XCTAssertEqual(mappedValue.version.macOSVersion, "11.0")
                        XCTAssertEqual(mappedValue.version.xcodeAppVersion, "12.0")
                        
                        guard let updatedState = self.persistedStore.server1 else {
                            XCTFail()
                            return
                        }
                        
                        XCTAssertEqual(updatedState.os, "11.0")
                        XCTAssertEqual(updatedState.xcode, "12.0")
                        
                        complete.fulfill()
                    }
                }
            }
        }
        
        wait(for: [complete], timeout: 1.0)
    }
}

private extension XcodeServer.Server {
    static let testServer: Self = {
        var server = XcodeServer.Server(id: .server1)
        server.version.api = .v19
        server.version.app = .v2_0
        server.version.macOSVersion = "10.15"
        server.version.xcodeAppVersion = "11.6"
        return server
    }()
    
    static let updateServer: Self = {
        var server = XcodeServer.Server(id: .server1)
        server.version.api = .v19
        server.version.app = .v2_0
        server.version.macOSVersion = "11.0"
        server.version.xcodeAppVersion = "12.0"
        return server
    }()
}

private extension XcodeServer.Server.ID {
    static let server1: Self = "xcodeserver.apple.com"
}

private extension XcodeServer.Bot.ID {
    static let bot1: Self = "705d82e27dbb120dddc09af79100116b"
}

private extension XcodeServer.Integration.ID {
    static let integration1: Self = "2ce4a2fd2f57d53039edddc51e0009cf"
}

extension CoreDataStore {
    var server1: XcodeServerModel_1_0_0.Server? {
        return XcodeServerModel_1_0_0.Server.server(.server1, in: container.persistentContainer.viewContext)
    }
    
    var bot1: XcodeServerModel_1_0_0.Bot? {
        return XcodeServerModel_1_0_0.Bot.bot(.bot1, in: container.persistentContainer.viewContext)
    }
    
    var integration1: XcodeServerModel_1_0_0.Integration? {
        return XcodeServerModel_1_0_0.Integration.integration(.integration1, in: container.persistentContainer.viewContext)
    }
}
#endif
