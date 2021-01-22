import XcodeServer
import Dispatch
#if canImport(CoreData)
import CoreData

extension PersistentContainer: SourceControlQueryable {
    public func getRemotes(queue: DispatchQueue?, completion: @escaping RemotesResultHandler) {
        let queue = queue ?? dispatchQueue
        internalQueue.async {
            self.performBackgroundTask { (context) in
                let repositories = Repository.repositories(in: context)
                let result = repositories.map { SourceControl.Remote($0) }
                queue.async {
                    completion(.success(result))
                }
            }
        }
    }
    
    public func getRemote(_ id: SourceControl.Remote.ID, queue: DispatchQueue?, completion: @escaping RemoteResultHandler) {
        let queue = queue ?? dispatchQueue
        internalQueue.async {
            self.performBackgroundTask { (context) in
                if let repository = Repository.repository(id, in: context) {
                    let result = SourceControl.Remote(repository)
                    queue.async {
                        completion(.success(result))
                    }
                } else {
                    queue.async {
                        completion(.failure(.noRemote(id)))
                    }
                }
            }
        }
    }
}

#endif
