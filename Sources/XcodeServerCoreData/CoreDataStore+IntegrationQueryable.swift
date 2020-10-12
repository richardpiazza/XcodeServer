import Dispatch
import XcodeServer
#if canImport(CoreData)
import CoreData

extension CoreDataStore: IntegrationQueryable {
    public func getIntegrations(queue: DispatchQueue?, completion: @escaping IntegrationsResultHandler) {
        InternalLog.coreData.info("Retrieving ALL Integrations")
        let queue = queue ?? returnQueue
        internalQueue.async {
            let integrations = self.persistentContainer.viewContext.integrations()
            let result = integrations.map({ XcodeServer.Integration($0) })
            queue.async {
                completion(.success(result))
            }
        }
    }
    
    public func getIntegrations(forBot id: XcodeServer.Bot.ID, queue: DispatchQueue?, completion: @escaping IntegrationsResultHandler) {
        InternalLog.coreData.info("Retrieving INTEGRATIONS for Bot [\(id)]")
        let queue = queue ?? returnQueue
        internalQueue.async {
            guard let bot = self.persistentContainer.viewContext.bot(withIdentifier: id) else {
                queue.async {
                    completion(.failure(.noBot(id)))
                }
                return
            }
            
            guard let integrations = bot.integrations?.map({ XcodeServer.Integration($0) }) else {
                queue.async {
                    completion(.success([]))
                }
                return
            }
            
            queue.async {
                completion(.success(integrations))
            }
        }
    }
    
    public func getIntegration(_ id: XcodeServer.Integration.ID, queue: DispatchQueue?, completion: @escaping IntegrationResultHandler) {
        InternalLog.coreData.info("Retrieving Integration [\(id)]")
        let queue = queue ?? returnQueue
        internalQueue.async {
            guard let integration = self.persistentContainer.viewContext.integration(withIdentifier: id) else {
                queue.async {
                    completion(.failure(.noIntegration(id)))
                }
                return
            }
            
            let result = XcodeServer.Integration(integration)
            
            queue.async {
                completion(.success(result))
            }
        }
    }
    
    public func getCommitsForIntegration(_ id: XcodeServer.Integration.ID, queue: DispatchQueue?, completion: @escaping CommitsResultHandler) {
        InternalLog.coreData.info("Retrieving COMMITS for Integration [\(id)]")
        let queue = queue ?? returnQueue
        internalQueue.async {
            guard let integration = self.persistentContainer.viewContext.integration(withIdentifier: id) else {
                queue.async {
                    completion(.failure(.noIntegration(id)))
                }
                return
            }
            
            guard let blueprints = integration.revisionBlueprints else {
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
    
    public func getIssuesForIntegration(_ id: XcodeServer.Integration.ID, queue: DispatchQueue?, completion: @escaping IssueCatalogResultHandler) {
        InternalLog.coreData.info("Retrieving ISSUES for Integration [\(id)]")
        let queue = queue ?? returnQueue
        internalQueue.async {
            guard let integration = self.persistentContainer.viewContext.integration(withIdentifier: id) else {
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

#endif
