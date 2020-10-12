import XcodeServer
#if canImport(CoreData)
import CoreData

public extension XcodeServerCoreData.IntegrationIssues {
    func update(_ catalog: XcodeServer.Integration.IssueCatalog, context: NSManagedObjectContext) {
        buildServiceErrors?.forEach({ context.delete($0) })
        buildServiceWarnings?.forEach({ context.delete($0) })
        freshAnalyzerWarnings?.forEach({ context.delete($0) })
        freshErrors?.forEach({ context.delete($0) })
        freshTestFailures?.forEach({ context.delete($0) })
        freshWarnings?.forEach({ context.delete($0) })
        resolvedAnalyzerWarnings?.forEach({ context.delete($0) })
        resolvedErrors?.forEach({ context.delete($0) })
        resolvedTestFailures?.forEach({ context.delete($0) })
        resolvedWarnings?.forEach({ context.delete($0) })
        unresolvedAnalyzerWarnings?.forEach({ context.delete($0) })
        unresolvedErrors?.forEach({ context.delete($0) })
        unresolvedTestFailures?.forEach({ context.delete($0) })
        unresolvedWarnings?.forEach({ context.delete($0) })
        
        catalog.buildServiceErrors.forEach({
            let issue = Issue(context: context)
            issue.update($0, context: context)
            issue.inverseBuildServiceErrors = self
        })
        
        catalog.buildServiceWarnings.forEach({
            let issue = Issue(context: context)
            issue.update($0, context: context)
            issue.inverseBuildServiceWarnings = self
        })
        
        catalog.errors.freshIssues.forEach({
            let issue = Issue(context: context)
            issue.update($0, context: context)
            issue.inverseFreshErrors = self
        })
        
        catalog.errors.resolvedIssues.forEach({
            let issue = Issue(context: context)
            issue.update($0, context: context)
            issue.inverseResolvedErrors = self
        })
        
        catalog.errors.unresolvedIssues.forEach({
            let issue = Issue(context: context)
            issue.update($0, context: context)
            issue.inverseUnresolvedErrors = self
        })
        
        catalog.warnings.freshIssues.forEach({
            let issue = Issue(context: context)
            issue.update($0, context: context)
            issue.inverseFreshWarnings = self
        })
        
        catalog.warnings.resolvedIssues.forEach({
            let issue = Issue(context: context)
            issue.update($0, context: context)
            issue.inverseResolvedWarnings = self
        })
        
        catalog.warnings.unresolvedIssues.forEach({
            let issue = Issue(context: context)
            issue.update($0, context: context)
            issue.inverseUnresolvedWarnings = self
        })
        
        catalog.analyzerWarnings.freshIssues.forEach({
            let issue = Issue(context: context)
            issue.update($0, context: context)
            issue.inverseFreshAnalyzerWarnings = self
        })
        
        catalog.analyzerWarnings.resolvedIssues.forEach({
            let issue = Issue(context: context)
            issue.update($0, context: context)
            issue.inverseResolvedAnalyzerWarnings = self
        })
        
        catalog.analyzerWarnings.unresolvedIssues.forEach({
            let issue = Issue(context: context)
            issue.update($0, context: context)
            issue.inverseUnresolvedAnalyzerWarnings = self
        })
        
        catalog.testFailures.freshIssues.forEach({
            let issue = Issue(context: context)
            issue.update($0, context: context)
            issue.inverseFreshTestFailures = self
        })
        
        catalog.testFailures.resolvedIssues.forEach({
            let issue = Issue(context: context)
            issue.update($0, context: context)
            issue.inverseResolvedTestFailures = self
        })
        
        catalog.testFailures.unresolvedIssues.forEach({
            let issue = Issue(context: context)
            issue.update($0, context: context)
            issue.inverseUnresolvedTestFailures = self
        })
    }
}
#endif
