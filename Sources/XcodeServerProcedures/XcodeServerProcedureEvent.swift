import XcodeServer

public enum XcodeServerProcedureEvent {
    
    public enum Action: String {
        case retrieve = "Retrieving"
        case create = "Creating"
        case update = "Updating"
        case delete = "Deleting"
    }
    
    case server(action: Action, id: Server.ID)
    case bot(action: Action, id: Bot.ID, name: String?, server: Server.ID?)
    case integration(action: Action, id: Integration.ID, number: Int?, bot: Bot.ID?)
    case commits(action: Action, id: Integration.ID)
    case issues(action: Action, id: Integration.ID)
    
    private static var botNames: [Bot.ID: String] = [:]
    private static var integrationNumbers: [Integration.ID: Int] = [:]
    
    private static func nameOfBot(_ id: Bot.ID?) -> String? {
        guard let id = id else {
            return nil
        }
        
        return botNames[id]
    }
    
    static func log(_ event: XcodeServerProcedureEvent) {
        switch event {
        case .server(let action, let id):
            print("\(action.rawValue) Server\n\t\tID:'\(id)'")
        case .bot(let action, let id, let name, let server):
            if let name = name {
                botNames[id] = name
            }
            
            switch (botNames[id], server) {
            case (.some(let _name), .some(let _server)):
                print("\(action.rawValue) \(_server) Bot '\(_name)'\n\t\tID: [\(id)]")
            case (.some(let _name), .none):
                print("\(action.rawValue) Bot '\(_name)'\n\t\tID: [\(id)]")
            case (.none, .some(let _server)):
                print("\(action.rawValue) \(_server) Bot\n\t\tID: [\(id)]")
            case (.none, .none):
                print("\(action.rawValue) Bot\n\t\tID: [\(id)]")
            }
        case .integration(let action, let id, let number, let bot):
            if let number = number {
                integrationNumbers[id] = number
            }
            
            switch (integrationNumbers[id], nameOfBot(bot)) {
            case (.some(let counter), .some(let name)):
                print("\(action.rawValue) \(name) Integration '\(counter)'\n\t\tID: [\(id)]")
            case (.some(let counter), .none):
                print("\(action.rawValue) Integration '\(counter)'\n\t\tID:[\(id)]")
            case (.none, .some(let name)):
                print("\(action.rawValue) \(name) Integration\n\t\tID:[\(id)]")
            case (.none, .none):
                print("\(action.rawValue) Integration\n\t\tID:[\(id)]")
            }
        case .commits(let action, let id):
            print("\(action.rawValue) Integration Commits\n\t\tID:'\(id)'")
        case .issues(let action, let id):
            print("\(action.rawValue) Integration Issues\n\t\tID:'\(id)'")
        }
    }
}
