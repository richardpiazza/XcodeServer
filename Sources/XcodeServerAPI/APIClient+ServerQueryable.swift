import Dispatch
import XcodeServer

extension APIClient: ServerQueryable {
    public func getServers(queue: DispatchQueue, completion: @escaping ServersResultHandler) {
        dispatchQueue.async {
            self.versions { (result) in
                switch result {
                case .failure(let error):
                    queue.async {
                        completion(.failure(.error(error)))
                    }
                case .success(let version):
                    let value = [Server(id: self.baseURL.host ?? "", version: version.0, api: version.1)]
                    queue.async {
                        completion(.success(value))
                    }
                }
            }
        }
    }
    
    public func getServer(_ id: Server.ID, queue: DispatchQueue, completion: @escaping ServerResultHandler) {
        dispatchQueue.async {
            self.versions { (result) in
                switch result {
                case .failure(let error):
                    queue.async {
                        completion(.failure(.error(error)))
                    }
                case .success(let version):
                    let value = Server(id: id, version: version.0, api: version.1)
                    queue.async {
                        completion(.success(value))
                    }
                }
            }
        }
    }
}
