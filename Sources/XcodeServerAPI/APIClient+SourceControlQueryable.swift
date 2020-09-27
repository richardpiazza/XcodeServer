import Dispatch
import XcodeServer

extension APIClient: SourceControlQueryable {
    public func getRemotes(queue: DispatchQueue, completion: @escaping RemotesResultHandler) {
        queue.async {
            completion(.failure(.message("Not Implemeneted")))
        }
    }
    
    public func getRemote(_ id: SourceControl.Remote.ID, queue: DispatchQueue, completion: @escaping RemoteResultHandler) {
        queue.async {
            completion(.failure(.message("Not Implemeneted")))
        }
    }
}
