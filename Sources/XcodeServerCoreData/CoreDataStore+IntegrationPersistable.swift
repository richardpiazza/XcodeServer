import XcodeServer
import Dispatch
#if canImport(CoreData)
import CoreData

extension CoreDataStore: IntegrationPersistable {
    public func saveIntegration(_ integration: XcodeServer.Integration, queue: DispatchQueue?, completion: @escaping IntegrationResultHandler) {
        InternalLog.coreData.info("Saving Integration '\(integration.number)' [\(integration.id)]")
        let queue = queue ?? returnQueue
        internalQueue.async {
            self.persistentContainer.performBackgroundTask { (context) in
                let _integration = context.integration(withIdentifier: integration.id) ?? XcodeServerCoreData.Integration(context: context)
                _integration.update(integration, context: context)
                
                do {
                    try context.save()
                    let result = XcodeServer.Integration(_integration)
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
    
    public func saveAssets(_ assets: XcodeServer.Integration.AssetCatalog, forIntegration id: XcodeServer.Integration.ID, queue: DispatchQueue?, completion: @escaping AssetCatalogResultHandler) {
        InternalLog.coreData.info("Saving ASSETS for Integration [\(id)]")
        let queue = queue ?? returnQueue
        internalQueue.async {
            self.persistentContainer.performBackgroundTask { (context) in
                guard let _integration = context.integration(withIdentifier: id) else {
                    queue.async {
                        completion(.failure(.noIntegration(id)))
                    }
                    return
                }
                
                _integration.assets?.update(assets, context: context)
                
                do {
                    try context.save()
                    guard let _assets = _integration.assets else {
                        queue.async {
                            completion(.failure(.message("No 'Assets' for integration '\(id)'.")))
                        }
                        return
                    }
                    
                    let result = XcodeServer.Integration.AssetCatalog(_assets)
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
                
                commits.forEach { (commit) in
                    guard let remoteId = commit.remoteId else {
                        InternalLog.coreData.warn("No Remote ID for commit: \(commit)")
                        return
                    }
                    
                    let repository: Repository
                    if let entity = context.repository(withIdentifier: remoteId) {
                        repository = entity
                    } else {
                        repository = Repository(context: context)
                        repository.identifier = remoteId
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
                guard let _integration = context.integration(withIdentifier: id) else {
                    queue.async {
                        completion(.failure(.noIntegration(id)))
                    }
                    return
                }
                
                _integration.issues?.update(issues, context: context)
                
                do {
                    try context.save()
                    guard let _issues = _integration.issues else {
                        queue.async {
                            completion(.failure(.message("No 'Issues' for integration '\(id)'.")))
                        }
                        return
                    }
                    
                    let result = XcodeServer.Integration.IssueCatalog(_issues)
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
