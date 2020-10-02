import XCTest
@testable import XcodeServer
@testable import XcodeServerAPI

class MockApiClient: AnyQueryable {
    private let dispatchQueue: DispatchQueue = .init(label: "MockApiClient")
    private let decoder: JSONDecoder = .init()
    public let serverId: Server.ID
    
    init(serverId: Server.ID) {
        self.serverId = serverId
    }
    
    // MARK: - ServerQueryable
    
    func getServers(queue: DispatchQueue, completion: @escaping ServersResultHandler) {
        getServer(serverId, queue: dispatchQueue) { (result) in
            queue.async {
                switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let server):
                    completion(.success([server]))
                }
            }
        }
    }
    
    func getServer(_ id: Server.ID, queue: DispatchQueue, completion: @escaping ServerResultHandler) {
        guard id == .example else {
            queue.async {
                completion(.failure(.noServer(id)))
            }
            return
        }
        
        #if swift(>=5.3)
        dispatchQueue.async {
            let resource: XCSVersion? = try? Bundle.module.decodeJson("versions", decoder: self.decoder)
            guard let versions = resource else {
                queue.async {
                    completion(.failure(.noServer(id)))
                }
                return
            }
            
            let result = Server(id: id, version: versions, api: 19)
            queue.async {
                completion(.success(result))
            }
        }
        #else
        queue.async {
            completion(.failure(.message("Not Implemented")))
        }
        #endif
    }
    
    // MARK: - BotQueryable
    
    func getBots(queue: DispatchQueue, completion: @escaping BotsResultHandler) {
        #if swift(>=5.3)
        struct Bots: Decodable {
            let count: Int
            let results: [XCSBot]
        }
        
        dispatchQueue.async {
            let resource: Bots? = try? Bundle.module.decodeJson("bots", decoder: self.decoder)
            guard let value = resource else {
                queue.async {
                    completion(.failure(.message("Invalid Resource")))
                }
                return
            }
            
            let result = value.results.map({ Bot($0, server: self.serverId) })
            queue.async {
                completion(.success(result))
            }
        }
        #else
        queue.async {
            completion(.failure(.message("Not Implemented")))
        }
        #endif
    }
    
    func getBot(_ id: Bot.ID, queue: DispatchQueue, completion: @escaping BotResultHandler) {
        #if swift(>=5.3)
        guard id == .dynumiteMacOS else {
            queue.async {
                completion(.failure(.noBot(id)))
            }
            return
        }
        
        dispatchQueue.async {
            let resource: XCSBot? = try? Bundle.module.decodeJson("bot", decoder: self.decoder)
            guard let value = resource else {
                queue.async {
                    completion(.failure(.message("Invalid Resource")))
                }
                return
            }
            
            let result = XcodeServer.Bot(value, server: self.serverId)
            queue.async {
                completion(.success(result))
            }
        }
        #else
        queue.async {
            completion(.failure(.message("Not Implemented")))
        }
        #endif
    }
    
    func getStatsForBot(_ id: Bot.ID, queue: DispatchQueue, completion: @escaping BotStatsResultHandler) {
        
    }
    
    // MARK: - IntegrationQueryable
    
    func getIntegrations(forBot id: Bot.ID, queue: DispatchQueue, completion: @escaping IntegrationsResultHandler) {
        
    }
    
    func getIntegration(_ id: Integration.ID, queue: DispatchQueue, completion: @escaping IntegrationResultHandler) {
        
    }
    
    func getCommitsForIntegration(_ id: Integration.ID, queue: DispatchQueue, completion: @escaping CommitsResultHandler) {
        
    }
    
    func getIssuesForIntegration(_ id: Integration.ID, queue: DispatchQueue, completion: @escaping IssueCatalogResultHandler) {
        
    }
    
    // MARK: - SourceControlQueryable
    
    func getRemote(_ id: SourceControl.Remote.ID, queue: DispatchQueue, completion: @escaping RemoteResultHandler) {
        queue.async {
            completion(.failure(.message("Not Implemented")))
        }
    }
    
    func getRemotes(queue: DispatchQueue, completion: @escaping RemotesResultHandler) {
        queue.async {
            completion(.failure(.message("Not Implemented")))
        }
    }
}