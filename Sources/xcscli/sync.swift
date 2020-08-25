import Foundation
import ArgumentParser
import XcodeServer
import XcodeServerAPI
#if canImport(CoreData)
import CoreData
import XcodeServerCoreData

final class Sync: ParsableCommand, Route {
    
    static var configuration: CommandConfiguration = {
        return CommandConfiguration(
            commandName: "sync",
            abstract: "Syncs data to a local Core Data store.",
            discussion: "",
            version: "",
            shouldDisplay: true,
            subcommands: [],
            defaultSubcommand: nil,
            helpNames: [.short, .long]
        )
    }()
    
    @Argument(help: "Fully Qualified Domain Name of the Xcode Server.")
    var server: String
    
    @Option(help: "Username credential for the Xcode Server. (Optional).")
    var username: String?
    
    @Option(help: "Password credential for the Xcode Server. (Optional).")
    var password: String?
    
    @Option(help: "The model version to use. [1.0.0].")
    var model: Model?
    
    @Flag(help: "Removes any store files prior to syncing.")
    var purge: Bool
    
    func validate() throws {
        try validateServer()
    }
    
    func run() throws {
        if purge {
            let fileManager = FileManager.default
            let storeURL = fileManager.storeURL
            let shmURL = storeURL.appendingPathExtension("-shm")
            let walURL = storeURL.appendingPathExtension("-wal")
            
            if fileManager.fileExists(atPath: walURL.path) {
                try fileManager.removeItem(at: walURL)
            }
            if fileManager.fileExists(atPath: shmURL.path) {
                try fileManager.removeItem(at: shmURL)
            }
            if fileManager.fileExists(atPath: storeURL.path) {
                try fileManager.removeItem(at: storeURL)
            }
        }
        
        let _model = model ?? Model.v1_0_0
        let container = NSPersistentContainer(model: _model)
        let manager: XcodeServer.Manager = Manager(container: container, authorizationDelegate: self)
        
        manager.createServer(withFQDN: server) { (error) in
            guard error == nil else {
                print(error!.localizedDescription)
                Self.exit()
            }
            
            manager.syncServer(withFQDN: self.server) { (syncError) in
                guard syncError == nil else {
                    print(syncError!.localizedDescription)
                    Self.exit()
                }
                
                print("Sync Complete")
                if let url = container.persistentStoreCoordinator.persistentStores.first?.url {
                    print("URL: \(url)")
                }
                
                container.unload()
                
                Self.exit()
            }
        }
        
        dispatchMain()
    }
}

extension Sync: ManagerAuthorizationDelegate {
}

extension Model: CaseIterable, ExpressibleByArgument {
    public typealias AllCases = [Model]
    
    public static var allCases: [Model] {
        return [.v1_0_0]
    }
    
    var stringValue: String {
        switch self {
        case .v1_0_0: return "1.0.0"
        }
    }
    
    public init?(argument: String) {
        guard let model = Model.allCases.first(where: { $0.stringValue == argument }) else {
            return nil
        }
        
        self = model
    }
}

#endif
