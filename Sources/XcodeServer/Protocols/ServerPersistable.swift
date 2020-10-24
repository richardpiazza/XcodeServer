import Dispatch

public protocol ServerPersistable {
    func saveServer(_ server: Server, queue: DispatchQueue?, completion: @escaping ServerResultHandler)
    func deleteServer(_ server: Server, queue: DispatchQueue?, completion: @escaping VoidResultHandler)
    
    func saveBots(_ bots: [Bot], forServer server: Server.ID, queue: DispatchQueue?, completion: @escaping BotsResultHandler)
}

// MARK: - Default Parameters
public extension ServerPersistable {
    func saveServer(_ server: Server, completion: @escaping ServerResultHandler) {
        saveServer(server, queue: nil, completion: completion)
    }
    
    func deleteServer(_ server: Server, completion: @escaping VoidResultHandler) {
        deleteServer(server, queue: nil, completion: completion)
    }
    
    func saveBots(_ bots: [Bot], forServer server: Server.ID, completion: @escaping BotsResultHandler) {
        saveBots(bots, forServer: server, queue: nil, completion: completion)
    }
}
