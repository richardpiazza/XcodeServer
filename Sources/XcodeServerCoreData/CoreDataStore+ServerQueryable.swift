import XcodeServer
import Dispatch
#if canImport(CoreData)
import CoreData

extension CoreDataStore: ServerQueryable {
    public func getServers(queue: DispatchQueue?, completion: @escaping ServersResultHandler) {
        InternalLog.coreData.info("Retrieving ALL Servers")
        let queue = queue ?? returnQueue
        internalQueue.async {
            let servers = self.persistentContainer.viewContext.servers()
            let result = servers.map { XcodeServer.Server($0) }
            queue.async {
                completion(.success(result))
            }
        }
    }
    
    public func getServer(_ id: XcodeServer.Server.ID, queue: DispatchQueue?, completion: @escaping ServerResultHandler) {
        InternalLog.coreData.info("Retrieving Server [\(id)]")
        let queue = queue ?? returnQueue
        internalQueue.async {
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
