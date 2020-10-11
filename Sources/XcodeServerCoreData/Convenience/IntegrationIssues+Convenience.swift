import XcodeServer
#if canImport(CoreData)
import CoreData

public extension XcodeServerCoreData.IntegrationIssues {
    func update(_ catalog: XcodeServer.Integration.IssueCatalog, context: NSManagedObjectContext) {
        buildServiceErrors?.removeAll()
        buildServiceWarnings?.removeAll()
        freshAnalyzerWarnings?.removeAll()
        freshErrors?.removeAll()
        freshTestFailures?.removeAll()
        freshWarnings?.removeAll()
        resolvedAnalyzerWarnings?.removeAll()
        resolvedErrors?.removeAll()
        resolvedTestFailures?.removeAll()
        resolvedWarnings?.removeAll()
        unresolvedAnalyzerWarnings?.removeAll()
        unresolvedErrors?.removeAll()
        unresolvedTestFailures?.removeAll()
        unresolvedWarnings?.removeAll()
        
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
    
//    func deleteAllIssues(context: NSManagedObjectContext) {
//        buildServiceErrors?.forEach({
//            $0.inverseBuildServiceErrors = nil
//            context.delete($0)
//        })
//
//        buildServiceWarnings?.forEach({
//            $0.inverseBuildServiceWarnings = nil
//            context.delete($0)
//        })
//
//        freshAnalyzerWarnings?.forEach({
//            $0.inverseFreshAnalyzerWarnings = nil
//            context.delete($0)
//        })
//
//        freshErrors?.forEach({
//            $0.inverseFreshErrors = nil
//            context.delete($0)
//        })
//
//        freshTestFailures?.forEach({
//            $0.inverseFreshTestFailures = nil
//            context.delete($0)
//        })
//
//        freshWarnings?.forEach({
//            $0.inverseFreshWarnings = nil
//            context.delete($0)
//        })
//
//        resolvedAnalyzerWarnings?.forEach({
//            $0.inverseResolvedAnalyzerWarnings = nil
//            context.delete($0)
//        })
//
//        resolvedErrors?.forEach({
//            $0.inverseResolvedErrors = nil
//            context.delete($0)
//        })
//
//        resolvedTestFailures?.forEach({
//            $0.inverseResolvedTestFailures = nil
//            context.delete($0)
//        })
//
//        resolvedWarnings?.forEach({
//            $0.inverseResolvedWarnings = nil
//            context.delete($0)
//        })
//
//        unresolvedAnalyzerWarnings?.forEach({
//            $0.inverseUnresolvedAnalyzerWarnings = nil
//            context.delete($0)
//        })
//
//        unresolvedErrors?.forEach({
//            $0.inverseUnresolvedErrors = nil
//            context.delete($0)
//        })
//
//        unresolvedTestFailures?.forEach({
//            $0.inverseUnresolvedTestFailures = nil
//            context.delete($0)
//        })
//
//        unresolvedWarnings?.forEach({
//            $0.inverseUnresolvedWarnings = nil
//            context.delete($0)
//        })
//    }
}
#endif
