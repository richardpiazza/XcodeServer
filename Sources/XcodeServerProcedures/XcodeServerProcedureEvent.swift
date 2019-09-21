import Foundation

public enum XcodeServerProcedureEvent {
    
    public enum Action {
        case create
        case update
        case delete
    }
    
    case server(action: Action, fqdn: String)
    case bot(action: Action, identifier: String, name: String)
    case integration(action: Action, identifier: String, number: Int32)
}
