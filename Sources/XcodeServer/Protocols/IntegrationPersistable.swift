import Dispatch
import Foundation

public protocol IntegrationPersistable {
    func saveIntegration(_ integration: Integration, queue: DispatchQueue?, completion: @escaping IntegrationResultHandler)
    func deleteIntegration(_ integration: Integration, queue: DispatchQueue?, completion: @escaping VoidResultHandler)
    
    func saveArchive(_ archive: Data, forIntegration id: Integration.ID, queue: DispatchQueue?, completion: @escaping DataResultHandler)
    func saveCommits(_ commits: [SourceControl.Commit], forIntegration id: Integration.ID, queue: DispatchQueue?, completion: @escaping CommitsResultHandler)
    func saveIssues(_ issues: Integration.IssueCatalog, forIntegration id: Integration.ID, queue: DispatchQueue?, completion: @escaping IssueCatalogResultHandler)
}

// MARK: - Default Parameters
public extension IntegrationPersistable {
    func saveIntegration(_ integration: Integration, completion: @escaping IntegrationResultHandler) {
        saveIntegration(integration, queue: nil, completion: completion)
    }
    
    func deleteIntegration(_ integration: Integration, completion: @escaping VoidResultHandler) {
        deleteIntegration(integration, queue: nil, completion: completion)
    }
    
    func saveArchive(_ archive: Data, forIntegration id: Integration.ID, completion: @escaping DataResultHandler) {
        saveArchive(archive, forIntegration: id, queue: nil, completion: completion)
    }
    
    func saveCommits(_ commits: [SourceControl.Commit], forIntegration id: Integration.ID, completion: @escaping CommitsResultHandler) {
        saveCommits(commits, forIntegration: id, queue: nil, completion: completion)
    }
    
    func saveIssues(_ issues: Integration.IssueCatalog, forIntegration id: Integration.ID, completion: @escaping IssueCatalogResultHandler) {
        saveIssues(issues, forIntegration: id, queue: nil, completion: completion)
    }
}
