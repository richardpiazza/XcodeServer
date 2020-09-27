import Dispatch

public protocol SourceControlQueryable {
    func getRemotes(queue: DispatchQueue, completion: @escaping RemotesResultHandler)
    func getRemote(_ id: SourceControl.Remote.ID, queue: DispatchQueue, completion: @escaping RemoteResultHandler)
}

// MARK: - Default Parameters
public extension SourceControlQueryable {
    func getRemotes(completion: @escaping RemotesResultHandler) {
        getRemotes(queue: .main, completion: completion)
    }
    
    func getRemote(_ id: SourceControl.Remote.ID, completion: @escaping RemoteResultHandler) {
        getRemote(id, queue: .main, completion: completion)
    }
}
