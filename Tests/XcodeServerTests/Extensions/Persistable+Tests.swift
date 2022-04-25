import XcodeServer

extension ServerPersistable {
    func persistServer(_ server: Server, completion: @escaping (Result<Server, Error>) -> Void) {
        Task {
            do {
                let value = try await persistServer(server)
                completion(.success(value))
            } catch {
                completion(.failure(error))
            }
        }
    }
}

extension BotPersistable {
    func persistBot(_ bot: Bot, forServer id: Server.ID, completion: @escaping (Result<Bot, Error>) -> Void) {
        Task {
            do {
                let value = try await persistBot(bot, forServer: id)
                completion(.success(value))
            } catch {
                completion(.failure(error))
            }
        }
    }
}

extension IntegrationPersistable {
    func persistIntegration(_ integration: Integration, forBot id: Bot.ID, completion: @escaping (Result<Integration, Error>) -> Void) {
        Task {
            do {
                let value = try await persistIntegration(integration, forBot: id)
                completion(.success(value))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func persistIntegrations(_ integrations: [Integration], forBot id: Bot.ID, completion: @escaping (Result<[Integration], Error>) -> Void) {
        Task {
            do {
                let value = try await persistIntegrations(integrations, forBot: id)
                completion(.success(value))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func persistIssues(_ issues: Integration.IssueCatalog, forIntegration id: Integration.ID, completion: @escaping (Result<Integration.IssueCatalog, Error>) -> Void) {
        Task {
            do {
                let value = try await persistIssues(issues, forIntegration: id)
                completion(.success(value))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
