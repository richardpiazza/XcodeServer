import XcodeServer
import Dispatch
#if canImport(CoreData)
import CoreData

extension PersistentContainer: IntegrationQueryable {
    public func getIntegrations(queue: DispatchQueue?, completion: @escaping IntegrationsResultHandler) {
        let queue = queue ?? dispatchQueue
        internalQueue.async {
            self.performBackgroundTask { (context) in
                let integrations = Integration.integrations(in: context)
                let result = integrations.map({ XcodeServer.Integration($0) })
                queue.async {
                    completion(.success(result))
                }
            }
        }
    }
    
    public func getIntegrations(forBot id: XcodeServer.Bot.ID, queue: DispatchQueue?, completion: @escaping IntegrationsResultHandler) {
        let queue = queue ?? dispatchQueue
        internalQueue.async {
            self.performBackgroundTask { (context) in
                let integrations = Integration.integrations(forBot: id, in: context)
                let result = integrations.map({ XcodeServer.Integration($0) })
                queue.async {
                    completion(.success(result))
                }
            }
        }
    }
    
    public func getIntegration(_ id: XcodeServer.Integration.ID, queue: DispatchQueue?, completion: @escaping IntegrationResultHandler) {
        let queue = queue ?? dispatchQueue
        internalQueue.async {
            self.performBackgroundTask { (context) in
                if let integration = Integration.integration(id, in: context) {
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
        let queue = queue ?? dispatchQueue
        queue.async {
            completion(.failure(.message("Not Implemented")))
        }
    }
    
    public func getCommitsForIntegration(_ id: XcodeServer.Integration.ID, queue: DispatchQueue?, completion: @escaping CommitsResultHandler) {
        let queue = queue ?? dispatchQueue
        internalQueue.async {
            self.performBackgroundTask { (context) in
                guard let integration = Integration.integration(id, in: context) else {
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
        let queue = queue ?? dispatchQueue
        internalQueue.async {
            self.performBackgroundTask { (context) in
                guard let integration = Integration.integration(id, in: context) else {
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
