import XcodeServer
import Dispatch
#if canImport(CoreData)
import CoreData

extension CoreDataStore: IntegrationPersistable {
    public func saveIntegration(_ integration: XcodeServer.Integration, forBot bot: XcodeServer.Bot.ID, queue: DispatchQueue?, completion: @escaping IntegrationResultHandler) {
        InternalLog.coreData.info("Saving Integration '\(integration.number)' [\(integration.id)]")
        let queue = queue ?? returnQueue
        internalQueue.async {
            self.persistentContainer.performBackgroundTask { (context) in
                let _integration: XcodeServerCoreData.Integration
                
                if let existing = context.integration(withIdentifier: integration.id) {
                    _integration = existing
                } else {
                    guard let _bot = context.bot(withIdentifier: bot) else {
                        queue.async {
                            completion(.failure(.noBot(bot)))
                        }
                        return
                    }
                    
                    _integration = context.make()
                    _integration.bot = _bot
                }
                
                _integration.update(integration, context: context)
                
                let result = XcodeServer.Integration(_integration)
                
                do {
                    try context.save()
                    queue.async {
                        completion(.success(result))
                    }
                } catch {
                    queue.async {
                        completion(.failure(.error(error)))
                    }
                }
            }
        }
    }
    
    public func saveIntegrations(_ integrations: [XcodeServer.Integration], forBot bot: XcodeServer.Bot.ID, queue: DispatchQueue?, completion: @escaping IntegrationsResultHandler) {
        let queue = queue ?? returnQueue
        internalQueue.async {
            self.persistentContainer.performBackgroundTask { (context) in
                guard let _bot = context.bot(withIdentifier: bot) else {
                    queue.async {
                        completion(.failure(.noBot(bot)))
                    }
                    return
                }
                
                var result: [XcodeServer.Integration] = []
                
                for integration in integrations {
                    InternalLog.coreData.info("Saving Integration '\(integration.number)' [\(integration.id)]")
                    
                    let _integration: XcodeServerCoreData.Integration
                    if let existing = context.integration(withIdentifier: integration.id) {
                        _integration = existing
                    } else {
                        _integration = context.make()
                        _integration.bot = _bot
                    }
                    
                    _integration.update(integration, context: context)
                    
                    result.append(XcodeServer.Integration(_integration))
                }
                
                do {
                    try context.save()
                    queue.async {
                        completion(.success(result))
                    }
                } catch {
                    queue.async {
                        completion(.failure(.error(error)))
                    }
                }
            }
        }
    }
    
    public func saveArchive(_ archive: Data, forIntegration id: XcodeServer.Integration.ID, queue: DispatchQueue?, completion: @escaping DataResultHandler) {
        InternalLog.coreData.info("Saving ARCHIVE for Integration [\(id)]")
        let queue = queue ?? returnQueue
        queue.async {
            completion(.failure(.message("Not Implemented")))
        }
    }
    
    public func saveCommits(_ commits: [SourceControl.Commit], forIntegration id: XcodeServer.Integration.ID, queue: DispatchQueue?, completion: @escaping CommitsResultHandler) {
        InternalLog.coreData.info("Saving COMMITS for Integration [\(id)]")
        let queue = queue ?? returnQueue
        internalQueue.async {
            self.persistentContainer.performBackgroundTask { (context) in
                guard let managedIntegration = context.integration(withIdentifier: id) else {
                    queue.async {
                        completion(.failure(.noIntegration(id)))
                    }
                    return
                }
                
                managedIntegration.hasRetrievedCommits = true
                
                commits.forEach { (commit) in
                    guard let remoteId = commit.remoteId else {
                        InternalLog.coreData.warn("No Remote ID for commit: \(commit)")
                        return
                    }
                    
                    let repository: Repository
                    if let entity = context.repository(withIdentifier: remoteId) {
                        repository = entity
                    } else {
                        repository = context.make()
                        repository.identifier = remoteId
                        InternalLog.coreData.debug("Creating REPOSITORY '??' [\(remoteId)]")
                    }
                    
                    repository.update(Set(arrayLiteral: commit), integration: managedIntegration, context: context)
                }
                
                do {
                    try context.save()
                    queue.async {
                        completion(.success([]))
                    }
                } catch {
                    queue.async {
                        completion(.failure(.error(error)))
                    }
                }
            }
        }
    }
    
    public func saveIssues(_ issues: XcodeServer.Integration.IssueCatalog, forIntegration id: XcodeServer.Integration.ID, queue: DispatchQueue?, completion: @escaping IssueCatalogResultHandler) {
        InternalLog.coreData.info("Saving ISSUES for Integration [\(id)]")
        let queue = queue ?? returnQueue
        internalQueue.async {
            self.persistentContainer.performBackgroundTask { (context) in
                guard let managedIntegration = context.integration(withIdentifier: id) else {
                    queue.async {
                        completion(.failure(.noIntegration(id)))
                    }
                    return
                }
                
                managedIntegration.hasRetrievedIssues = true
                managedIntegration.issues?.update(issues, context: context)
                
                guard let _issues = managedIntegration.issues else {
                    queue.async {
                        completion(.failure(.message("No 'Issues' for integration '\(id)'.")))
                    }
                    return
                }
                
                let result = XcodeServer.Integration.IssueCatalog(_issues)
                
                do {
                    try context.save()
                    queue.async {
                        completion(.success(result))
                    }
                } catch {
                    queue.async {
                        completion(.failure(.error(error)))
                    }
                }
            }
        }
    }
    
    public func deleteIntegration(_ integration: XcodeServer.Integration, queue: DispatchQueue?, completion: @escaping VoidResultHandler) {
        InternalLog.coreData.info("Removing Integration '\(integration.number)' [\(integration.id)]")
        let queue = queue ?? returnQueue
        internalQueue.async {
            self.persistentContainer.performBackgroundTask { (context) in
                guard let _integration = context.integration(withIdentifier: integration.id) else {
                    queue.async {
                        completion(.failure(.noIntegration(integration.id)))
                    }
                    return
                }
                
                context.delete(_integration)
                
                do {
                    try context.save()
                    queue.async {
                        completion(.success(()))
                    }
                } catch {
                    queue.async {
                        completion(.failure(.error(error)))
                    }
                }
            }
        }
    }
}

#endif
