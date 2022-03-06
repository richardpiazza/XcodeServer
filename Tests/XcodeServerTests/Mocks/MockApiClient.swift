@testable import XcodeServer
@testable import XcodeServerAPI
import Foundation

class MockApiClient: EntityQueryable {
    
    struct NotImplemented: Error {}
    
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
    
    func servers() async throws -> [Server] {
        throw NotImplemented()
    }
    
    func server(withId id: Server.ID) async throws -> Server {
        throw NotImplemented()
    }
    
    // MARK: - BotQueryable
    
    func bots() async throws -> [Bot] {
        throw NotImplemented()
    }
    
    func bots(forServer id: Server.ID) async throws -> [Bot] {
        throw NotImplemented()
    }
    
    func bot(withId id: Bot.ID) async throws -> Bot {
        throw NotImplemented()
    }
    
    func bot(withId id: Bot.ID, completion: @escaping (Result<Bot, Error>) -> Void) {
        Task {
            do {
                let value = try await bot(withId: id)
                completion(.success(value))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func stats(forBot id: Bot.ID) async throws -> Bot.Stats {
        throw NotImplemented()
    }
    
    func stats(forBot id: Bot.ID, completion: @escaping (Result<Bot.Stats, Error>) -> Void) {
        Task {
            do {
                let value = try await stats(forBot: id)
                completion(.success(value))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - IntegrationQueryable
    
    func integrations() async throws -> [Integration] {
        throw NotImplemented()
    }
    
    func integration(withId id: Integration.ID) async throws -> Integration {
        throw NotImplemented()
    }
    
    func integration(withId id: Integration.ID, completion: @escaping (Result<Integration, Error>) -> Void) {
        Task {
            do {
                let value = try await integration(withId: id)
                completion(.success(value))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func integrations(forBot id: Bot.ID) async throws -> [Integration] {
        throw NotImplemented()
    }
    
    func commits(forIntegration id: Integration.ID) async throws -> [SourceControl.Commit] {
        throw NotImplemented()
    }
    
    func commits(forIntegration id: Integration.ID, completion: @escaping (Result<[SourceControl.Commit], Error>) -> Void) {
        Task {
            do {
                let value = try await commits(forIntegration: id)
                completion(.success(value))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func issues(forIntegration id: Integration.ID) async throws -> Integration.IssueCatalog {
        throw NotImplemented()
    }
    
    func issues(forIntegration id: Integration.ID, completion: @escaping (Result<Integration.IssueCatalog, Error>) -> Void) {
        Task {
            do {
                let value = try await issues(forIntegration: id)
                completion(.success(value))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func archive(forIntegration id: Integration.ID) async throws -> Data {
        throw NotImplemented()
    }
    
    // MARK: - SourceControlQueryable
    
    func remotes() async throws -> [SourceControl.Remote] {
        throw NotImplemented()
    }
    
    func remote(withId id: SourceControl.Remote.ID) async throws -> SourceControl.Remote {
        throw NotImplemented()
    }
}
