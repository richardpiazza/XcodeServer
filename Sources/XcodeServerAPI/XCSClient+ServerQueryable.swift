import Dispatch
import XcodeServer

extension XCSClient: ServerQueryable {
    public func getServers(queue: DispatchQueue?, completion: @escaping ServersResultHandler) {
        InternalLog.api.info("Retrieving ALL Servers")
        let queue = queue ?? returnQueue
        internalQueue.async {
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
    
    public func getServer(_ id: Server.ID, queue: DispatchQueue?, completion: @escaping ServerResultHandler) {
        InternalLog.api.info("Retrieving VERSIONS for Server [\(id)]")
        let queue = queue ?? returnQueue
        internalQueue.async {
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
