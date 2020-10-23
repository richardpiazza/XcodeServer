import XcodeServer
import ProcedureKit
import Foundation

public class SyncGroupProcedure: GroupProcedure {
    
    public enum Behavior {
        /// 'Intelegent'
        case `default`
        ///
        case minimal
        ///
        case maximum
    }
    
}

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
@available(swift, introduced: 5.1)
public class SyncServerGroupProcedure: SyncGroupProcedure {
    
    private let source: AnyQueryable
    private let destination: AnyPersistable
    private let server: Server
    private let behavior: Behavior
    
    public init(source: AnyQueryable, destination: AnyPersistable, server: Server, behavior: Behavior) {
        self.source = source
        self.destination = destination
        self.server = server
        self.behavior = behavior
        
        super.init(operations: [])
        
        let version = SyncVersionProcedure(source: source, destination: destination, server: server)
        let bots = SyncServerBotsProcedure(source: source, destination: destination, server: server)
        bots.addDependency(version)
        bots.addDidFinishBlockObserver { (proc, error) in
            guard let bots = proc.bots else {
                return
            }
            
            bots.forEach({
                self.produceSyncStats(for: $0)
                self.produceSyncIntegrations(for: $0)
            })
        }
        
        addChildren([version, bots])
    }
    
    private func produceSyncStats(for bot: Bot) {
        
    }
    
    private func produceSyncIntegrations(for bot: Bot) {
        
    }
    
    private func produceSync(for integration: Integration) {
        
    }
    
    private func produceSyncIssues(for integration: Integration) {
        
    }
    
    private func produceSyncCommits(for integration: Integration) {
        
    }
}
