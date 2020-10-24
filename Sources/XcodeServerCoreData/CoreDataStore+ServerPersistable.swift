import XcodeServer
import Dispatch
#if canImport(CoreData)
import CoreData

extension CoreDataStore: ServerPersistable {
    public func saveServer(_ server: XcodeServer.Server, queue: DispatchQueue?, completion: @escaping ServerResultHandler) {
        InternalLog.coreData.info("Saving Server [\(server.id)]")
        let queue = queue ?? returnQueue
        internalQueue.async {
            self.persistentContainer.performBackgroundTask { (context) in
                let _server = context.server(withFQDN: server.id) ?? XcodeServerCoreData.Server(context: context)
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
        InternalLog.coreData.info("Saving BOTS for Server [\(server)]")
        let queue = queue ?? returnQueue
        internalQueue.async {
            self.persistentContainer.performBackgroundTask { (context) in
                guard let _server = context.server(withFQDN: server) else {
                    queue.async {
                        completion(.failure(.noServer(server)))
                    }
                    return
                }
                
                _server.update(Set(bots), context: context)
                
                let result = (_server.bots ?? []).map({ XcodeServer.Bot($0) })
                
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
        InternalLog.coreData.info("Removing Server [\(server.id)]")
        let queue = queue ?? returnQueue
        internalQueue.async {
            self.persistentContainer.performBackgroundTask { (context) in
                guard let _server = context.server(withFQDN: server.id) else {
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
