import XcodeServer
import Dispatch
#if canImport(CoreData)
import CoreData

extension CoreDataStore: SourceControlQueryable {
    public func getRemotes(queue: DispatchQueue?, completion: @escaping RemotesResultHandler) {
        InternalLog.coreData.info("Retrieving ALL Remotes")
        let queue = queue ?? returnQueue
        internalQueue.async {
            let repositories = self.persistentContainer.viewContext.repositories()
            let result = repositories.map { SourceControl.Remote($0) }
            queue.async {
                completion(.success(result))
            }
        }
    }
    
    public func getRemote(_ id: SourceControl.Remote.ID, queue: DispatchQueue?, completion: @escaping RemoteResultHandler) {
        InternalLog.coreData.info("Retrieving Remote [\(id)]")
        let queue = queue ?? returnQueue
        internalQueue.async {
            if let repository = self.persistentContainer.viewContext.repository(withIdentifier: id) {
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

#endif
