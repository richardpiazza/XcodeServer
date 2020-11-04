@testable import XcodeServer
@testable import XcodeServerAPI
import Foundation

class MockApiClient: AnyQueryable {
    let dispatchQueue: DispatchQueue = .init(label: "MockApiClient")
    let returnQueue: DispatchQueue
    let serverId: Server.ID
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return formatter
    }()
    
    lazy var decoder: JSONDecoder = {
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
        queue.async {
            completion(.failure(.message("Not Implemented")))
        }
    }
    
    func getServer(_ id: Server.ID, queue: DispatchQueue?, completion: @escaping ServerResultHandler) {
        let queue = queue ?? returnQueue
        queue.async {
            completion(.failure(.message("Not Implemented")))
        }
    }
    
    // MARK: - BotQueryable
    
    func getBots(queue: DispatchQueue?, completion: @escaping BotsResultHandler) {
        let queue = queue ?? returnQueue
        queue.async {
            completion(.failure(.message("Not Implemented")))
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
        queue.async {
            completion(.failure(.message("Not Implemented")))
        }
    }
    
    func getStatsForBot(_ id: Bot.ID, queue: DispatchQueue?, completion: @escaping BotStatsResultHandler) {
        let queue = queue ?? returnQueue
        queue.async {
            completion(.failure(.message("Not Implemented")))
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
        queue.async {
            completion(.failure(.message("Not Implemented")))
        }
    }
    
    func getArchiveForIntegration(_ id: Integration.ID, queue: DispatchQueue?, completion: @escaping DataResultHandler) {
        let queue = queue ?? returnQueue
        queue.async {
            completion(.failure(.message("Not Implemented")))
        }
    }
    
    func getCommitsForIntegration(_ id: Integration.ID, queue: DispatchQueue?, completion: @escaping CommitsResultHandler) {
        let queue = queue ?? returnQueue
        queue.async {
            completion(.failure(.message("Not Implemented")))
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
