import XCTest
@testable import XcodeServer
@testable import XcodeServerCoreData

final class CoreDataTests: XCTestCase {
    
    #if canImport(CoreData)
    lazy var persistedStore: CoreDataStore = {
        return CoreDataStore(model: .v1_0_0, persisted: false)
    }()
    
    var store: (ServerPersistable & ServerQueryable) {
        return persistedStore
    }
    #endif
    
    func testWriteServer() throws {
        #if canImport(CoreData)
        let server: XcodeServer.Server = .testServer
        let complete = expectation(description: "complete")
        
        store.saveServer(server) { (result) in
            switch result {
            case .failure(let error):
                XCTFail(error.localizedDescription)
            case .success(let mappedValue):
                XCTAssertEqual(mappedValue.id, .example)
                XCTAssertEqual(mappedValue.version.api, .v19)
                XCTAssertEqual(mappedValue.version.app, .v2_0)
                XCTAssertEqual(mappedValue.version.macOSVersion, "10.15")
                XCTAssertEqual(mappedValue.version.xcodeAppVersion, "11.6")
                XCTAssertEqual(mappedValue.url, URL(string: "https://xcodeserver.apple.com:20343/api"))
                
                guard let managedServer = self.persistedStore.managedServer else {
                    XCTFail("No persisted 'Server' with FQDN '\(server.id)'.")
                    return
                }
                
                XCTAssertEqual(managedServer.fqdn, server.id)
                XCTAssertEqual(managedServer.apiVersion, 19)
                XCTAssertEqual(managedServer.xcodeServer, "2.0")
                XCTAssertEqual(managedServer.os, "10.15")
                XCTAssertEqual(managedServer.xcode, "11.6")
                XCTAssertEqual(managedServer.apiURL, URL(string: "https://xcodeserver.apple.com:20343/api"))
                
                complete.fulfill()
            }
        }
        
        wait(for: [complete], timeout: 0.5)
        #endif
    }
    
    func testUpdateServer() {
        #if canImport(CoreData)
        let server: XcodeServer.Server = .testServer
        let complete = expectation(description: "complete")
        
        store.saveServer(server) { (result) in
            switch result {
            case .failure(let error):
                XCTFail(error.localizedDescription)
            case .success:
                guard let initialState = self.persistedStore.managedServer else {
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
                        
                        guard let updatedState = self.persistedStore.managedServer else {
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
        #endif
    }
}

#if canImport(CoreData)
extension CoreDataStore {
    var managedServer: XcodeServerCoreData.Server? {
        let request = XcodeServerCoreData.Server.fetchRequest() as! NSFetchRequest<XcodeServerCoreData.Server>
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(XcodeServerCoreData.Server.fqdn), XcodeServer.Server.ID.example)
        return try? persistentContainer.viewContext.fetch(request).first
    }
}
#endif

extension XcodeServer.Server.ID {
    static let example = "xcodeserver.apple.com"
}

extension XcodeServer.Server {
    static let testServer: Self = {
        var server = XcodeServer.Server(id: .example)
        server.version.api = .v19
        server.version.app = .v2_0
        server.version.macOSVersion = "10.15"
        server.version.xcodeAppVersion = "11.6"
        return server
    }()
    
    static let updateServer: Self = {
        var server = XcodeServer.Server(id: .example)
        server.version.api = .v19
        server.version.app = .v2_0
        server.version.macOSVersion = "11.0"
        server.version.xcodeAppVersion = "12.0"
        return server
    }()
}
