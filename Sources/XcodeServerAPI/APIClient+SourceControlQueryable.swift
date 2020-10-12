import Dispatch
import XcodeServer

extension APIClient: SourceControlQueryable {
    public func getRemotes(queue: DispatchQueue?, completion: @escaping RemotesResultHandler) {
        let queue = queue ?? returnQueue
        queue.async {
            completion(.failure(.message("Not Implemented")))
        }
    }
    
    public func getRemote(_ id: SourceControl.Remote.ID, queue: DispatchQueue?, completion: @escaping RemoteResultHandler) {
        let queue = queue ?? returnQueue
        queue.async {
            completion(.failure(.message("Not Implemented")))
        }
    }
}
