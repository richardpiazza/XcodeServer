import Dispatch
import XcodeServer

extension APIClient: IntegrationQueryable {
    public func getIntegrations(forBot id: Bot.ID, queue: DispatchQueue?, completion: @escaping IntegrationsResultHandler) {
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
    
    public func getCommitsForIntegration(_ id: Integration.ID, queue: DispatchQueue?, completion: @escaping CommitsResultHandler) {
        let queue = queue ?? returnQueue
        internalQueue.async {
            self.commits(forIntegrationWithIdentifier: id) { (result) in
                switch result {
                case .failure(let error):
                    queue.async {
                        completion(.failure(.error(error)))
                    }
                case .success(let commits):
                    var repositoryCommits: [XCSRepositoryCommit] = []
                    commits.forEach({ commit in
                        commit.commits?.forEach({ (dictionary) in
                            repositoryCommits.append(contentsOf: dictionary.value)
                        })
                    })
                    let value = repositoryCommits.map({ SourceControl.Commit($0, remote: $0.repositoryID, integration: id) })
                    queue.async {
                        completion(.success(value))
                    }
                }
            }
        }
    }
    
    public func getIssuesForIntegration(_ id: Integration.ID, queue: DispatchQueue?, completion: @escaping IssueCatalogResultHandler) {
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
