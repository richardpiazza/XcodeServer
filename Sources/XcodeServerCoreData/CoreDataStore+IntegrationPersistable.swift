import XcodeServer
import Dispatch
#if canImport(CoreData)
import CoreData

extension CoreDataStore: IntegrationPersistable {
    public func saveIntegration(_ integration: XcodeServer.Integration, queue: DispatchQueue, completion: @escaping IntegrationResultHandler) {
        dispatchQueue.async {
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
    
    public func saveAssets(_ assets: XcodeServer.Integration.AssetCatalog, forIntegration id: XcodeServer.Integration.ID, queue: DispatchQueue, completion: @escaping AssetCatalogResultHandler) {
        dispatchQueue.async {
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
    
    public func saveCommits(_ commits: [SourceControl.Commit], forIntegration id: XcodeServer.Integration.ID, queue: DispatchQueue, completion: @escaping CommitsResultHandler) {
        dispatchQueue.async {
            self.persistentContainer.performBackgroundTask { (context) in
                guard let managedIntegration = context.integration(withIdentifier: id) else {
                    queue.async {
                        completion(.failure(.noIntegration(id)))
                    }
                    return
                }
                
                for sourceControlCommit in commits {
                    let managedCommit = context.commit(withHash: sourceControlCommit.id) ?? XcodeServerCoreData.Commit(context: context)
                    managedCommit.update(sourceControlCommit, context: context)
                    
                    if context.revisionBlueprint(withCommit: managedCommit, andIntegration: managedIntegration) == nil {
                        let link = RevisionBlueprint(context: context)
                        link.commit = managedCommit
                        link.integration = managedIntegration
                    }
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
    
    public func saveIssues(_ issues: XcodeServer.Integration.IssueCatalog, forIntegration id: XcodeServer.Integration.ID, queue: DispatchQueue, completion: @escaping IssueCatalogResultHandler) {
        dispatchQueue.async {
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
    
    public func deleteIntegration(_ integration: XcodeServer.Integration, queue: DispatchQueue, completion: @escaping VoidResultHandler) {
        dispatchQueue.async {
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
