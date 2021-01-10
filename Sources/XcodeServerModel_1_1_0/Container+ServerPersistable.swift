import XcodeServer
import Dispatch
#if canImport(CoreData)
import CoreData

extension Container: ServerPersistable {
    public func saveServer(_ server: XcodeServer.Server, queue: DispatchQueue?, completion: @escaping ServerResultHandler) {
        InternalLog.persistence.info("Saving Server [\(server.id)]")
        let queue = queue ?? dispatchQueue
        internalQueue.async {
            self.persistentContainer.performBackgroundTask { (context) in
                let _server = Server.server(server.id, in: context) ?? context.make()
                _server.update(server, context: context)
                _server.lastUpdate = Date()

                let result = XcodeServer.Server(_server)
                
                do {
                    try context.save()
                    queue.async {
                        completion(.success(result))
                    }
                } catch {
                    queue.async {
                        completion(.failure(.error(error)))
                    }
                }
            }
        }
    }
    
    public func saveBots(_ bots: [XcodeServer.Bot], forServer server: XcodeServer.Server.ID, queue: DispatchQueue?, completion: @escaping BotsResultHandler) {
        InternalLog.persistence.info("Saving BOTS for Server [\(server)]")
        let queue = queue ?? dispatchQueue
        internalQueue.async {
            self.persistentContainer.performBackgroundTask { (context) in
                guard let _server = Server.server(server, in: context) else {
                    queue.async {
                        completion(.failure(.noServer(server)))
                    }
                    return
                }
                
                _server.update(Set(bots), context: context)
                
                let result = (_server.bots as? Set<Bot> ?? []).map({ XcodeServer.Bot($0) })
                
                do {
                    try context.save()
                    queue.async {
                        completion(.success(result))
                    }
                } catch {
                    queue.async {
                        completion(.failure(.error(error)))
                    }
                }
            }
        }
    }
    
    public func deleteServer(_ server: XcodeServer.Server, queue: DispatchQueue?, completion: @escaping VoidResultHandler) {
        InternalLog.persistence.info("Removing Server [\(server.id)]")
        let queue = queue ?? dispatchQueue
        internalQueue.async {
            self.persistentContainer.performBackgroundTask { (context) in
                guard let _server = Server.server(server.id, in: context) else {
                    queue.async {
                        completion(.failure(.noServer(server.id)))
                    }
                    return
                }
                
                context.delete(_server)
                
                do {
                    try context.save()
                    queue.async {
                        completion(.success(()))
                    }
                } catch {
                    queue.async {
                        completion(.failure(.error(error)))
                    }
                }
            }
        }
    }
}
#endif
