import Dispatch

public protocol ServerPersistable {
    func saveServer(_ server: Server, queue: DispatchQueue?, completion: @escaping ServerResultHandler)
    func deleteServer(_ server: Server, queue: DispatchQueue?, completion: @escaping VoidResultHandler)
}

// MARK: - Default Parameters
public extension ServerPersistable {
    func saveServer(_ server: Server, completion: @escaping ServerResultHandler) {
        saveServer(server, queue: nil, completion: completion)
    }
    
    func deleteServer(_ server: Server, completion: @escaping VoidResultHandler) {
        deleteServer(server, queue: nil, completion: completion)
    }
}
