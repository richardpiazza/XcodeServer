import XcodeServer
import Dispatch
#if canImport(CoreData)
import CoreData

extension CoreDataStore: ServerQueryable {
    public func getServers(queue: DispatchQueue?, completion: @escaping ServersResultHandler) {
        let queue = queue ?? returnQueue
        internalQueue.async {
            self.persistentContainer.performBackgroundTask { (context) in
                let servers = context.servers()
                let result = servers.map { XcodeServer.Server($0) }
                queue.async {
                    completion(.success(result))
                }
            }
        }
    }
    
    public func getServer(_ id: XcodeServer.Server.ID, queue: DispatchQueue?, completion: @escaping ServerResultHandler) {
        let queue = queue ?? returnQueue
        internalQueue.async {
            self.persistentContainer.performBackgroundTask { (context) in
                if let server = context.server(withFQDN: id) {
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
