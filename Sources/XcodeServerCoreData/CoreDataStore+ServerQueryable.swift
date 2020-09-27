import XcodeServer
import Dispatch
#if canImport(CoreData)
import CoreData

extension CoreDataStore: ServerQueryable {
    public func getServers(queue: DispatchQueue, completion: @escaping ServersResultHandler) {
        dispatchQueue.async {
            let servers = self.persistentContainer.viewContext.servers()
            let result = servers.map { XcodeServer.Server($0) }
            queue.async {
                completion(.success(result))
            }
        }
    }
    
    public func getServer(_ id: XcodeServer.Server.ID, queue: DispatchQueue, completion: @escaping ServerResultHandler) {
        dispatchQueue.async {
            if let server = self.persistentContainer.viewContext.server(withFQDN: id) {
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

#endif
