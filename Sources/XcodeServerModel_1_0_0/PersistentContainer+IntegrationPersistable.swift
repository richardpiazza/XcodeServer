import XcodeServer
import Dispatch
#if canImport(CoreData)
import CoreData

extension PersistentContainer: IntegrationPersistable {
    public func saveIntegration(_ integration: XcodeServer.Integration, forBot bot: XcodeServer.Bot.ID, queue: DispatchQueue?, completion: @escaping IntegrationResultHandler) {
        InternalLog.persistence.info("Saving Integration '\(integration.number)' [\(integration.id)]")
        let queue = queue ?? dispatchQueue
        internalQueue.async {
            self.performBackgroundTask { (context) in
                let _integration: Integration
                
                if let existing = Integration.integration(integration.id, in: context) {
                    _integration = existing
                } else {
                    guard let _bot = Bot.bot(bot, in: context) else {
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
        let queue = queue ?? dispatchQueue
        internalQueue.async {
            self.performBackgroundTask { (context) in
                guard let _bot = Bot.bot(bot, in: context) else {
                    queue.async {
                        completion(.failure(.noBot(bot)))
                    }
                    return
                }
                
                var result: [XcodeServer.Integration] = []
                
                for integration in integrations {
                    InternalLog.persistence.info("Saving Integration '\(integration.number)' [\(integration.id)]")
                    
                    let _integration: Integration
                    if let existing = Integration.integration(integration.id, in: context) {
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
        InternalLog.persistence.info("Saving ARCHIVE for Integration [\(id)]")
        let queue = queue ?? dispatchQueue
        queue.async {
            completion(.failure(.message("Not Implemented")))
        }
    }
    
    public func saveCommits(_ commits: [SourceControl.Commit], forIntegration id: XcodeServer.Integration.ID, queue: DispatchQueue?, completion: @escaping CommitsResultHandler) {
        InternalLog.persistence.info("Saving COMMITS for Integration [\(id)]")
        let queue = queue ?? dispatchQueue
        internalQueue.async {
            self.performBackgroundTask { (context) in
                guard let managedIntegration = Integration.integration(id, in: context) else {
                    queue.async {
                        completion(.failure(.noIntegration(id)))
                    }
                    return
                }
                
                managedIntegration.hasRetrievedCommits = true
                
                commits.forEach { (commit) in
                    guard let remoteId = commit.remoteId else {
                        InternalLog.persistence.warn("No Remote ID for commit: \(commit)")
                        return
                    }
                    
                    let repository: Repository
                    if let entity = Repository.repository(remoteId, in: context) {
                        repository = entity
                    } else {
                        repository = context.make()
                        repository.identifier = remoteId
                        InternalLog.persistence.debug("Creating REPOSITORY '??' [\(remoteId)]")
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
        InternalLog.persistence.info("Saving ISSUES for Integration [\(id)]")
        let queue = queue ?? dispatchQueue
        internalQueue.async {
            self.performBackgroundTask { (context) in
                guard let managedIntegration = Integration.integration(id, in: context) else {
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
        InternalLog.persistence.info("Removing Integration '\(integration.number)' [\(integration.id)]")
        let queue = queue ?? dispatchQueue
        internalQueue.async {
            self.performBackgroundTask { (context) in
                guard let _integration = Integration.integration(integration.id, in: context) else {
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
