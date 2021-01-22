import Dispatch
import XcodeServer

extension XCSClient: IntegrationQueryable {
    public func getIntegrations(queue: DispatchQueue?, completion: @escaping IntegrationsResultHandler) {
        InternalLog.api.info("Retrieving ALL Integrations")
        let queue = queue ?? returnQueue
        internalQueue.async {
            self.integrations { (result) in
                switch result {
                case .failure(let error):
                    queue.async {
                        completion(.failure(.error(error)))
                    }
                case .success(let integrations):
                    let value = integrations.map { Integration($0, bot: nil, server: self.fqdn) }
                    queue.async {
                        completion(.success(value))
                    }
                }
            }
        }
    }
    
    public func getIntegrations(forBot id: Bot.ID, queue: DispatchQueue?, completion: @escaping IntegrationsResultHandler) {
        InternalLog.api.info("Retrieving INTEGRATIONS for Bot [\(id)]")
        let queue = queue ?? returnQueue
        internalQueue.async {
            self.integrations(forBotWithIdentifier: id) { (result) in
                switch result {
                case .failure(let error):
                    queue.async {
                        completion(.failure(.error(error)))
                    }
                case .success(let integrations):
                    let value = integrations.map { Integration($0, bot: id, server: self.fqdn) }
                    queue.async {
                        completion(.success(value))
                    }
                }
            }
        }
    }
    
    public func getIntegration(_ id: Integration.ID, queue: DispatchQueue?, completion: @escaping IntegrationResultHandler) {
        InternalLog.api.info("Retrieving Integration [\(id)]")
        let queue = queue ?? returnQueue
        internalQueue.async {
            self.integration(withIdentifier: id) { (result) in
                switch result {
                case .failure(let error):
                    queue.async {
                        completion(.failure(.error(error)))
                    }
                case .success(let integration):
                    let value = Integration(integration, bot: id, server: self.fqdn)
                    queue.async {
                        completion(.success(value))
                    }
                }
            }
        }
    }
    
    public func getArchiveForIntegration(_ id: Integration.ID, queue: DispatchQueue?, completion: @escaping DataResultHandler) {
        InternalLog.api.info("Retrieving ARCHIVE for Integration [\(id)]")
        let queue = queue ?? returnQueue
        internalQueue.async {
            self.archive(forIntegrationWithIdentifier: id) { (result) in
                switch result {
                case .failure(let error):
                    queue.async {
                        completion(.failure(.error(error)))
                    }
                case .success(let value):
                    queue.async {
                        completion(.success(value.1))
                    }
                }
            }
        }
    }
    
    public func getCommitsForIntegration(_ id: Integration.ID, queue: DispatchQueue?, completion: @escaping CommitsResultHandler) {
        InternalLog.api.info("Retrieving COMMITS for Integration [\(id)]")
        let queue = queue ?? returnQueue
        internalQueue.async {
            self.commits(forIntegrationWithIdentifier: id) { (result) in
                switch result {
                case .failure(let error):
                    queue.async {
                        completion(.failure(.error(error)))
                    }
                case .success(let commits):
                    let value = commits.commits(forIntegration: id)
                    queue.async {
                        completion(.success(value))
                    }
                }
            }
        }
    }
    
    public func getIssuesForIntegration(_ id: Integration.ID, queue: DispatchQueue?, completion: @escaping IssueCatalogResultHandler) {
        InternalLog.api.info("Retrieving ISSUES for Integration [\(id)]")
        let queue = queue ?? returnQueue
        internalQueue.async {
            self.issues(forIntegrationWithIdentifier: id) { (result) in
                switch result {
                case .failure(let error):
                    queue.async {
                        completion(.failure(.error(error)))
                    }
                case .success(let issues):
                    let value = Integration.IssueCatalog(issues, integration: id)
                    queue.async {
                        completion(.success(value))
                    }
                }
            }
        }
    }
}
