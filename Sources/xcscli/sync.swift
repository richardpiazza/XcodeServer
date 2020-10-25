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
        let store = CoreDataStore(model: _model)
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
                if let url = store.persistentContainer.persistentStoreCoordinator.persistentStores.first?.url {
                    print("\(url)")
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
