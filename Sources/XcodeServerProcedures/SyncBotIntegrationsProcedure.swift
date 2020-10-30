import XcodeServer
import ProcedureKit

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
@available(swift, introduced: 5.1)
public class SyncBotIntegrationsProcedure: GroupProcedure {
    
    public var integrations: [Integration]?
    
    public init(source: IntegrationQueryable, destination: IntegrationPersistable, bot: Bot) {
        super.init(operations: [])
        
        let get = GetBotIntegrationsProcedure(source: source, input: bot.id)
        get.addDidFinishBlockObserver { (proc, error) in
            self.integrations = proc.output.success
        }
        let update = UpdateBotIntegrationsProcedure(destination: destination, bot: bot)
        update.injectResult(from: get)
        
        addChildren(get, update)
    }
}

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
@available(swift, introduced: 5.1)
public class SyncBotIntegrationsGroupProcedure: GroupProcedure, OutputProcedure {
    
    public typealias Source = IntegrationQueryable
    public typealias Destination = (IntegrationQueryable & IntegrationPersistable)
    
    public var output: Pending<ProcedureResult<[Integration]>> = .pending
    
    public init(source: Source, destination: Destination, bot: Bot) {
        super.init(operations: [])
        
        let getIntegrationsFromSource = GetBotIntegrationsProcedure(source: source, input: bot.id)
        let updateIntegrationsAtStore = UpdateBotIntegrationsProcedure(destination: destination, bot: bot)
        updateIntegrationsAtStore.injectResult(from: getIntegrationsFromSource)
        let getUpdatedIntegrations = GetBotIntegrationsProcedure(source: destination, input: bot.id)
        getUpdatedIntegrations.addDependency(updateIntegrationsAtStore)
        getUpdatedIntegrations.addWillFinishBlockObserver { (proc, error, event) in
            self.output = proc.output
        }
        
        addChildren([getIntegrationsFromSource, updateIntegrationsAtStore, getUpdatedIntegrations])
    }
}
