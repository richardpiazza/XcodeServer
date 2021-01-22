import XcodeServer
import Dispatch
#if canImport(CoreData)
import CoreData

extension PersistentContainer: ServerQueryable {
    public func getServers(queue: DispatchQueue?, completion: @escaping ServersResultHandler) {
        let queue = queue ?? dispatchQueue
        internalQueue.async {
            self.performBackgroundTask { (context) in
                let servers = Server.servers(in: context)
                let result = servers.map { XcodeServer.Server($0) }
                queue.async {
                    completion(.success(result))
                }
            }
        }
    }
    
    public func getServer(_ id: XcodeServer.Server.ID, queue: DispatchQueue?, completion: @escaping ServerResultHandler) {
        let queue = queue ?? dispatchQueue
        internalQueue.async {
            self.performBackgroundTask { (context) in
                if let server = Server.server(id, in: context) {
                    let result = XcodeServer.Server(server)
                    queue.async {
                        completion(.success(result))
                    }
                } else {
                    queue.async {
                        completion(.failure(.noServer(id)))
                    }
                }
            }
        }
    }
}

#endif
