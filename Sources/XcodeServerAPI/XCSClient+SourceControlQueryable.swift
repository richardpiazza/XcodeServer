import Dispatch
import XcodeServer

extension XCSClient: SourceControlQueryable {
    public func getRemotes(queue: DispatchQueue?, completion: @escaping RemotesResultHandler) {
        InternalLog.apiClient.info("Retrieving ALL Remotes")
        let queue = queue ?? returnQueue
        queue.async {
            completion(.failure(.message("Not Implemented")))
        }
    }
    
    public func getRemote(_ id: SourceControl.Remote.ID, queue: DispatchQueue?, completion: @escaping RemoteResultHandler) {
        InternalLog.apiClient.info("Retrieving Remote [\(id)]")
        let queue = queue ?? returnQueue
        queue.async {
            completion(.failure(.message("Not Implemented")))
        }
    }
}
