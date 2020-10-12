import XcodeServer
import Dispatch
#if canImport(CoreData)
import CoreData

extension CoreDataStore: SourceControlPersistable {
    public func saveRemote(_ remote: SourceControl.Remote, queue: DispatchQueue?, completion: @escaping RemoteResultHandler) {
        InternalLog.coreData.info("Saving Remote [\(remote.id)]")
        let queue = queue ?? returnQueue
        internalQueue.async {
            self.persistentContainer.performBackgroundTask { (context) in
                let _remote = context.repository(withIdentifier: remote.id) ?? XcodeServerCoreData.Repository(context: context)
                _remote.update(remote, context: context)
                
                let result = SourceControl.Remote(_remote)
                
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
    
    public func deleteRemote(_ remote: SourceControl.Remote, queue: DispatchQueue?, completion: @escaping VoidResultHandler) {
        InternalLog.coreData.info("Removing Remote [\(remote.id)]")
        let queue = queue ?? returnQueue
        internalQueue.async {
            self.persistentContainer.performBackgroundTask { (context) in
                guard let _remote = context.repository(withIdentifier: remote.id) else {
                    queue.async {
                        completion(.failure(.noRemote(remote.id)))
                    }
                    return
                }
                
                context.delete(_remote)
                
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
