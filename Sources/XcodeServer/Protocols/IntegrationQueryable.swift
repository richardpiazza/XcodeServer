import Dispatch

public protocol IntegrationQueryable {
    func getIntegrations(queue: DispatchQueue?, completion: @escaping IntegrationsResultHandler)
    func getIntegrations(forBot id: Bot.ID, queue: DispatchQueue?, completion: @escaping IntegrationsResultHandler)
    func getIntegration(_ id: Integration.ID, queue: DispatchQueue?, completion: @escaping IntegrationResultHandler)
    func getCommitsForIntegration(_ id: Integration.ID, queue: DispatchQueue?, completion: @escaping CommitsResultHandler)
    func getIssuesForIntegration(_ id: Integration.ID, queue: DispatchQueue?, completion: @escaping IssueCatalogResultHandler)
}

// MARK: - Default Parameters
public extension IntegrationQueryable {
    func getIntegrations(completion: @escaping IntegrationsResultHandler) {
        getIntegrations(queue: nil, completion: completion)
    }
    
    func getIntegrations(forBot id: Bot.ID, completion: @escaping IntegrationsResultHandler) {
        getIntegrations(forBot: id, queue: nil, completion: completion)
    }
    
    func getIntegration(_ id: Integration.ID, completion: @escaping IntegrationResultHandler) {
        getIntegration(id, queue: nil, completion: completion)
    }
    
    func getCommitsForIntegration(_ id: Integration.ID, completion: @escaping CommitsResultHandler) {
        getCommitsForIntegration(id, queue: nil, completion: completion)
    }
    
    func getIssuesForIntegration(_ id: Integration.ID, completion: @escaping IssueCatalogResultHandler) {
        getIssuesForIntegration(id, queue: nil, completion: completion)
    }
}
