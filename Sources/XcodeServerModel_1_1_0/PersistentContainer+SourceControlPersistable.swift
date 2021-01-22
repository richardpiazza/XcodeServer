import XcodeServer
import Dispatch
#if canImport(CoreData)
import CoreData

extension PersistentContainer: SourceControlPersistable {
    public func saveRemote(_ remote: SourceControl.Remote, queue: DispatchQueue?, completion: @escaping RemoteResultHandler) {
        InternalLog.persistence.info("Saving Remote [\(remote.id)]")
        let queue = queue ?? dispatchQueue
        internalQueue.async {
            self.performBackgroundTask { (context) in
                let repository: Repository
                if let entity = Repository.repository(remote.id, in: context) {
                    repository = entity
                } else {
                    repository = context.make()
                    InternalLog.persistence.debug("Creating REPOSITORY '\(remote.name)' [\(remote.id)]")
                }
                
                repository.update(remote, context: context)
                
                let result = SourceControl.Remote(repository)
                
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
        InternalLog.persistence.info("Removing Remote [\(remote.id)]")
        let queue = queue ?? dispatchQueue
        internalQueue.async {
            self.performBackgroundTask { (context) in
                guard let _remote = Repository.repository(remote.id, in: context) else {
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
