@testable import XcodeServer
@testable import XcodeServerAPI
import Foundation

class MockApiClient: AnyQueryable {
    private let dispatchQueue: DispatchQueue = .init(label: "MockApiClient")
    private let returnQueue: DispatchQueue
    public let serverId: Server.ID
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return formatter
    }()
    
    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }()
    
    init(serverId: Server.ID, dispatchQueue: DispatchQueue = .main) {
        self.serverId = serverId
        returnQueue = dispatchQueue
    }
    
    // MARK: - ServerQueryable
    
    func getServers(queue: DispatchQueue?, completion: @escaping ServersResultHandler) {
        let queue = queue ?? returnQueue
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
    
    func getServer(_ id: Server.ID, queue: DispatchQueue?, completion: @escaping ServerResultHandler) {
        let queue = queue ?? returnQueue
        guard id == .example else {
            queue.async {
                completion(.failure(.noServer(id)))
            }
            return
        }
        
        dispatchQueue.async {
            let resource: XCSVersion
            do {
                #if swift(>=5.3)
                resource = try Bundle.module.decodeJson("versions", decoder: self.decoder)
                #else
                resource = try versionsJson.decodeMultiline(decoder: self.decoder)
                #endif
            } catch {
                queue.async {
                    completion(.failure(.error(error)))
                }
                return
            }
            
            let result = Server(id: id, version: resource, api: 19)
            queue.async {
                completion(.success(result))
            }
        }
    }
    
    // MARK: - BotQueryable
    
    func getBots(queue: DispatchQueue?, completion: @escaping BotsResultHandler) {
        let queue = queue ?? returnQueue
        
        struct Bots: Decodable {
            let count: Int
            let results: [XCSBot]
        }
        
        dispatchQueue.async {
            let resource: Bots
            do {
                #if swift(>=5.3)
                resource = try Bundle.module.decodeJson("bots", decoder: self.decoder)
                #else
                resource = try botsJson.decodeMultiline(decoder: self.decoder)
                #endif
            } catch {
                queue.async {
                    completion(.failure(.error(error)))
                }
                return
            }
            
            let result = resource.results.map({ Bot($0, server: self.serverId) })
            queue.async {
                completion(.success(result))
            }
        }
    }
    
    func getBots(forServer id: Server.ID, queue: DispatchQueue?, completion: @escaping BotsResultHandler) {
        let queue = queue ?? returnQueue
        queue.async {
            completion(.failure(.message("Not Implemented")))
        }
    }
    
    func getBot(_ id: Bot.ID, queue: DispatchQueue?, completion: @escaping BotResultHandler) {
        let queue = queue ?? returnQueue
        guard id == .dynumiteMacOS else {
            queue.async {
                completion(.failure(.noBot(id)))
            }
            return
        }
        
        dispatchQueue.async {
            let resource: XCSBot
            do {
                #if swift(>=5.3)
                resource = try Bundle.module.decodeJson("bot", decoder: self.decoder)
                #else
                resource = try botJson.decodeMultiline(decoder: self.decoder)
                #endif
            } catch {
                queue.async {
                    completion(.failure(.error(error)))
                }
                return
            }
            
            let result = XcodeServer.Bot(resource, server: self.serverId)
            queue.async {
                completion(.success(result))
            }
        }
    }
    
    func getStatsForBot(_ id: Bot.ID, queue: DispatchQueue?, completion: @escaping BotStatsResultHandler) {
        let queue = queue ?? returnQueue
        guard id == .dynumiteMacOS else {
            queue.async {
                completion(.failure(.noBot(id)))
            }
            return
        }
        
        dispatchQueue.async {
            let resource: XCSStats
            do {
                #if swift(>=5.3)
                resource = try Bundle.module.decodeJson("stats", decoder: self.decoder)
                #else
                resource = try statsJson.decodeMultiline(decoder: self.decoder)
                #endif
            } catch {
                queue.async {
                    completion(.failure(.error(error)))
                }
                return
            }
            
            let result = XcodeServer.Bot.Stats(resource)
            queue.async {
                completion(.success(result))
            }
        }
    }
    
    // MARK: - IntegrationQueryable
    
    func getIntegrations(queue: DispatchQueue?, completion: @escaping IntegrationsResultHandler) {
        let queue = queue ?? returnQueue
        queue.async {
            completion(.failure(.message("Not Implemented")))
        }
    }
    
    func getIntegrations(forBot id: Bot.ID, queue: DispatchQueue?, completion: @escaping IntegrationsResultHandler) {
        let queue = queue ?? returnQueue
        queue.async {
            completion(.failure(.message("Not Implemented")))
        }
    }
    
    func getIntegration(_ id: Integration.ID, queue: DispatchQueue?, completion: @escaping IntegrationResultHandler) {
        let queue = queue ?? returnQueue
        
        let json: String
        switch id {
        case .dynumite24:
            #if swift(>=5.3)
            json = "integration"
            #else
            json = integrationJson
            #endif
        case .structured18:
            #if swift(>=5.3)
            json = "structured18"
            #else
            json = structured18Json
            #endif
        default:
            queue.async {
                completion(.failure(.noIntegration(id)))
            }
            return
        }
        
        dispatchQueue.async {
            let resource: XCSIntegration
            do {
                #if swift(>=5.3)
                resource = try Bundle.module.decodeJson(json, decoder: self.decoder)
                #else
                resource = try json.decodeMultiline(decoder: self.decoder)
                #endif
            } catch {
                queue.async {
                    completion(.failure(.error(error)))
                }
                return
            }
            
            let result = XcodeServer.Integration(resource, bot: nil, server: nil)
            queue.async {
                completion(.success(result))
            }
        }
    }
    
    func getArchiveForIntegration(_ id: Integration.ID, queue: DispatchQueue?, completion: @escaping DataResultHandler) {
        let queue = queue ?? returnQueue
        queue.async {
            completion(.failure(.message("Not Implemented")))
        }
    }
    
    func getCommitsForIntegration(_ id: Integration.ID, queue: DispatchQueue?, completion: @escaping CommitsResultHandler) {
        struct Commits: Decodable {
            let count: Int
            let results: [XCSCommit]
        }
        
        let queue = queue ?? returnQueue
        
        let json: String
        switch id {
        case .structured18:
            #if swift(>=5.3)
            json = "structured18_commits"
            #else
            json = structured18CommitsJson
            #endif
        default:
            queue.async {
                completion(.failure(.noIntegration(id)))
            }
            return
        }
        
        dispatchQueue.async {
            let resource: Commits
            do {
                #if swift(>=5.3)
                resource = try Bundle.module.decodeJson(json, decoder: self.decoder)
                #else
                resource = try json.decodeMultiline(decoder: self.decoder)
                #endif
            } catch {
                queue.async {
                    completion(.failure(.error(error)))
                }
                return
            }
            
            let commits = resource.results.commits(forIntegration: id)
            queue.async {
                completion(.success(commits))
            }
        }
    }
    
    func getIssuesForIntegration(_ id: Integration.ID, queue: DispatchQueue?, completion: @escaping IssueCatalogResultHandler) {
        let queue = queue ?? returnQueue
        queue.async {
            completion(.failure(.message("Not Implemented")))
        }
    }
    
    // MARK: - SourceControlQueryable
    
    func getRemote(_ id: SourceControl.Remote.ID, queue: DispatchQueue?, completion: @escaping RemoteResultHandler) {
        let queue = queue ?? returnQueue
        queue.async {
            completion(.failure(.message("Not Implemented")))
        }
    }
    
    func getRemotes(queue: DispatchQueue?, completion: @escaping RemotesResultHandler) {
        let queue = queue ?? returnQueue
        queue.async {
            completion(.failure(.message("Not Implemented")))
        }
    }
}
