import XcodeServer
import Dispatch
#if canImport(CoreData)
import CoreData

extension CoreDataStore: IntegrationQueryable {
    public func getIntegrations(queue: DispatchQueue?, completion: @escaping IntegrationsResultHandler) {
        let queue = queue ?? returnQueue
        internalQueue.async {
            self.persistentContainer.performBackgroundTask { (context) in
                let integrations = context.integrations()
                let result = integrations.map({ XcodeServer.Integration($0) })
                queue.async {
                    completion(.success(result))
                }
            }
        }
    }
    
    public func getIntegrations(forBot id: XcodeServer.Bot.ID, queue: DispatchQueue?, completion: @escaping IntegrationsResultHandler) {
        let queue = queue ?? returnQueue
        internalQueue.async {
            self.persistentContainer.performBackgroundTask { (context) in
                let integrations = context.integrations(forBot: id)
                let result = integrations.map({ XcodeServer.Integration($0) })
                queue.async {
                    completion(.success(result))
                }
            }
        }
    }
    
    public func getIntegration(_ id: XcodeServer.Integration.ID, queue: DispatchQueue?, completion: @escaping IntegrationResultHandler) {
        let queue = queue ?? returnQueue
        internalQueue.async {
            self.persistentContainer.performBackgroundTask { (context) in
                if let integration = context.integration(withIdentifier: id) {
                    let result = XcodeServer.Integration(integration)
                    queue.async {
                        completion(.success(result))
                    }
                } else {
                    queue.async {
                        completion(.failure(.noIntegration(id)))
                    }
                }
            }
        }
    }
    
    public func getArchiveForIntegration(_ id: XcodeServer.Integration.ID, queue: DispatchQueue?, completion: @escaping DataResultHandler) {
        let queue = queue ?? returnQueue
        queue.async {
            completion(.failure(.message("Not Implemented")))
        }
    }
    
    public func getCommitsForIntegration(_ id: XcodeServer.Integration.ID, queue: DispatchQueue?, completion: @escaping CommitsResultHandler) {
        let queue = queue ?? returnQueue
        internalQueue.async {
            self.persistentContainer.performBackgroundTask { (context) in
                guard let integration = context.integration(withIdentifier: id) else {
                    queue.async {
                        completion(.failure(.noIntegration(id)))
                    }
                    return
                }
                
                guard let blueprints = integration.revisionBlueprints as? Set<RevisionBlueprint> else {
                    queue.async {
                        completion(.success([]))
                    }
                    return
                }
                
                let commits = blueprints.compactMap { $0.commit }
                let result = commits.map { SourceControl.Commit($0) }
                queue.async {
                    completion(.success(result))
                }
            }
        }
    }
    
    public func getIssuesForIntegration(_ id: XcodeServer.Integration.ID, queue: DispatchQueue?, completion: @escaping IssueCatalogResultHandler) {
        let queue = queue ?? returnQueue
        internalQueue.async {
            self.persistentContainer.performBackgroundTask { (context) in
                guard let integration = context.integration(withIdentifier: id) else {
                    queue.async {
                        completion(.failure(.noIntegration(id)))
                    }
                    return
                }
                
                guard let issues = integration.issues else {
                    queue.async {
                        completion(.success(XcodeServer.Integration.IssueCatalog()))
                    }
                    return
                }
                
                let result = XcodeServer.Integration.IssueCatalog(issues)
                queue.async {
                    completion(.success(result))
                }
            }
        }
    }
}

#endif
