import XcodeServer
import Dispatch
#if canImport(CoreData)
import CoreData

extension CoreDataStore: ServerPersistable {
    public func saveServer(_ server: XcodeServer.Server, queue: DispatchQueue?, completion: @escaping ServerResultHandler) {
        InternalLog.info("Saving Server [\(server.id)]")
        let queue = queue ?? returnQueue
        internalQueue.async {
            self.persistentContainer.performBackgroundTask { (context) in
                let _server = context.server(withFQDN: server.id) ?? XcodeServerCoreData.Server(context: context)
                _server.update(server, context: context)

                do {
                    try context.save()
                    let result = XcodeServer.Server(_server)
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
        InternalLog.info("Removing Server [\(server.id)]")
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
