import Dispatch
import XcodeServer

extension APIClient: IntegrationQueryable {
    public func getIntegrations(forBot id: Bot.ID, queue: DispatchQueue, completion: @escaping IntegrationsResultHandler) {
        dispatchQueue.async {
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
    
    public func getIntegration(_ id: Integration.ID, queue: DispatchQueue, completion: @escaping IntegrationResultHandler) {
        dispatchQueue.async {
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
    
    public func getCommitsForIntegration(_ id: Integration.ID, queue: DispatchQueue, completion: @escaping CommitsResultHandler) {
        dispatchQueue.async {
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
                    let value = repositoryCommits.map({ SourceControl.Commit($0, integration: id) })
                    queue.async {
                        completion(.success(value))
                    }
                }
            }
        }
    }
    
    public func getIssuesForIntegration(_ id: Integration.ID, queue: DispatchQueue, completion: @escaping IssueCatalogResultHandler) {
        dispatchQueue.async {
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
