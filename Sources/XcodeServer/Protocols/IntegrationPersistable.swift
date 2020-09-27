import Dispatch

public protocol IntegrationPersistable {
    func saveIntegration(_ integration: Integration, queue: DispatchQueue, completion: @escaping IntegrationResultHandler)
    func deleteIntegration(_ integration: Integration, queue: DispatchQueue, completion: @escaping VoidResultHandler)
    
    func saveAssets(_ assets: Integration.AssetCatalog, forIntegration id: Integration.ID, queue: DispatchQueue, completion: @escaping AssetCatalogResultHandler)
    func saveCommits(_ commits: [SourceControl.Commit], forIntegration id: Integration.ID, queue: DispatchQueue, completion: @escaping CommitsResultHandler)
    func saveIssues(_ issues: Integration.IssueCatalog, forIntegration id: Integration.ID, queue: DispatchQueue, completion: @escaping IssueCatalogResultHandler)
}

// MARK: - Default Parameters
public extension IntegrationPersistable {
    func saveIntegration(_ integration: Integration, completion: @escaping IntegrationResultHandler) {
        saveIntegration(integration, queue: .main, completion: completion)
    }
    
    func deleteIntegration(_ integration: Integration, completion: @escaping VoidResultHandler) {
        deleteIntegration(integration, queue: .main, completion: completion)
    }
    
    func saveAssets(_ assets: Integration.AssetCatalog, forIntegration id: Integration.ID, completion: @escaping AssetCatalogResultHandler) {
        saveAssets(assets, forIntegration: id, queue: .main, completion: completion)
    }
    
    func saveCommits(_ commits: [SourceControl.Commit], forIntegration id: Integration.ID, completion: @escaping CommitsResultHandler) {
        saveCommits(commits, forIntegration: id, queue: .main, completion: completion)
    }
    
    func saveIssues(_ issues: Integration.IssueCatalog, forIntegration id: Integration.ID, completion: @escaping IssueCatalogResultHandler) {
        saveIssues(issues, forIntegration: id, queue: .main, completion: completion)
    }
}
