import XcodeServer

public enum XcodeServerProcedureEvent {
    
    public enum Action {
        case create
        case update
        case delete
    }
    
    @available(*, deprecated, renamed: "server(action:id:)")
    case server(action: Action, fqdn: String)
    case server(action: Action, id: Server.ID)
    @available(*, deprecated, renamed: "bot(action:id:name:)")
    case bot(action: Action, identifier: String, name: String)
    case bot(action: Action, id: Bot.ID, name: String)
    @available(*, deprecated, renamed: "integration(action:id:number:)")
    case integration(action: Action, identifier: String, number: Int32)
    case integration(action: Action, id: Integration.ID, number: Int)
}
