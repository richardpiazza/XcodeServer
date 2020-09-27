import Dispatch

public protocol SourceControlPersistable {
    func saveRemote(_ remote: SourceControl.Remote, queue: DispatchQueue, completion: @escaping RemoteResultHandler)
    func deleteRemote(_ remote: SourceControl.Remote, queue: DispatchQueue, completion: @escaping VoidResultHandler)
}

// MARK: - Default Parameters
public extension SourceControlPersistable {
    func saveRemote(_ remote: SourceControl.Remote, completion: @escaping RemoteResultHandler) {
        saveRemote(remote, queue: .main, completion: completion)
    }
    
    func deleteRemote(_ remote: SourceControl.Remote, completion: @escaping VoidResultHandler) {
        deleteRemote(remote, queue: .main, completion: completion)
    }
}
