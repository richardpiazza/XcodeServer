public enum PersistenceEvent {
    
    public enum Action {
        case create
        case update
        case delete
    }
    
    case server(action: Action, id: Server.ID)
    case bot(action: Action, id: Bot.ID, name: String)
    case integration(action: Action, id: Integration.ID, number: Int)
}
