import Foundation
import ArgumentParser
import XcodeServer
import XcodeServerAPI
import XcodeServerUtility
#if canImport(CoreData)
import CoreData
import XcodeServerCoreData

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
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
    
    @Option(help: "The minimum output log level.")
    var logLevel: InternalLog.Level = .warn
    
    func validate() throws {
        try validateServer()
    }
    
    func run() throws {
        configureLog()
        
        if purge {
            try FileManager.default.purgeDefaultStore()
        }
        
        let _model = model ?? Model.current
        let store = try CoreDataStore(model: _model)
        let manager: XcodeServerUtility.Manager = Manager(store: store, authorizationDelegate: self)
        
        manager.createServer(withId: server) { (error) in
            guard error == nil else {
                print(error!.localizedDescription)
                Self.exit()
            }
            
            let start = Date()
            manager.syncServer(withId: self.server) { (syncError) in
                guard syncError == nil else {
                    print(syncError!.localizedDescription)
                    Self.exit()
                }
                
                let end = Date()
                print("Sync Complete - \(end.timeIntervalSince(start)) Seconds")
                if let path = store.persistentContainer.persistentStoreCoordinator.persistentStores.first?.url?.path {
                    print("\(path)")
                }
                
                store.persistentContainer.unload()
                
                Self.exit()
            }
        }
        
        dispatchMain()
    }
}

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension Sync: ManagerAuthorizationDelegate {
}

extension Model: ExpressibleByArgument {
}

extension InternalLog.Level: ExpressibleByArgument {
}

#endif
