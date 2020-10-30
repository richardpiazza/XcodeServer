import Dispatch

public protocol ServerQueryable {
    func getServers(queue: DispatchQueue?, completion: @escaping ServersResultHandler)
    func getServer(_ id: Server.ID, queue: DispatchQueue?, completion: @escaping ServerResultHandler)
}

// MARK: - Default Parameters
public extension ServerQueryable {
    func getServers(completion: @escaping ServersResultHandler) {
        getServers(queue: nil, completion: completion)
    }
    
    func getServer(_ id: Server.ID, completion: @escaping ServerResultHandler) {
        getServer(id, queue: nil, completion: completion)
    }
}
