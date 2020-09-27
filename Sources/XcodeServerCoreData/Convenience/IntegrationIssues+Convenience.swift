import XcodeServer
#if canImport(CoreData)
import CoreData

public extension XcodeServerCoreData.IntegrationIssues {
    func update(_ catalog: XcodeServer.Integration.IssueCatalog, context: NSManagedObjectContext) {
        deleteAllIssues(context: context)
        
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
    
    func deleteAllIssues(context: NSManagedObjectContext) {
        buildServiceErrors?.forEach({
            $0.inverseBuildServiceErrors = nil
            context.delete($0)
        })
        
        buildServiceWarnings?.forEach({
            $0.inverseBuildServiceWarnings = nil
            context.delete($0)
        })
        
        freshAnalyzerWarnings?.forEach({
            $0.inverseFreshAnalyzerWarnings = nil
            context.delete($0)
        })
        
        freshErrors?.forEach({
            $0.inverseFreshErrors = nil
            context.delete($0)
        })
        
        freshTestFailures?.forEach({
            $0.inverseFreshTestFailures = nil
            context.delete($0)
        })
        
        freshWarnings?.forEach({
            $0.inverseFreshWarnings = nil
            context.delete($0)
        })
        
        resolvedAnalyzerWarnings?.forEach({
            $0.inverseResolvedAnalyzerWarnings = nil
            context.delete($0)
        })
        
        resolvedErrors?.forEach({
            $0.inverseResolvedErrors = nil
            context.delete($0)
        })
        
        resolvedTestFailures?.forEach({
            $0.inverseResolvedTestFailures = nil
            context.delete($0)
        })
        
        resolvedWarnings?.forEach({
            $0.inverseResolvedWarnings = nil
            context.delete($0)
        })
        
        unresolvedAnalyzerWarnings?.forEach({
            $0.inverseUnresolvedAnalyzerWarnings = nil
            context.delete($0)
        })
        
        unresolvedErrors?.forEach({
            $0.inverseUnresolvedErrors = nil
            context.delete($0)
        })
        
        unresolvedTestFailures?.forEach({
            $0.inverseUnresolvedTestFailures = nil
            context.delete($0)
        })
        
        unresolvedWarnings?.forEach({
            $0.inverseUnresolvedWarnings = nil
            context.delete($0)
        })
    }
}

/*
 extension XcodeServerCoreData.IntegrationIssues {
     public func update(withIntegrationIssues issues: XCSIssues) {
         guard let context = self.managedObjectContext else {
             return
         }
         
         // Build Service Errors
         if let set = self.buildServiceErrors {
             for issue in set {
                 issue.inverseBuildServiceErrors = nil
                 context.delete(issue)
             }
         }
         
         if let buildServiceErrors = issues.buildServiceErrors {
             for error in buildServiceErrors {
                 let new = Issue(context: context)
                 new.identifier = error.id
                 new.inverseBuildServiceErrors = self
                 new.update(withIssue: error)
             }
         }
         
         // Build Service Warnings
         if let set = self.buildServiceWarnings {
             for issue in set {
                 issue.inverseBuildServiceWarnings = nil
                 context.delete(issue)
             }
         }
         
         if let buildServiceWarnings = issues.buildServiceWarnings {
             for warning in buildServiceWarnings {
                 let new = Issue(context: context)
                 new.identifier = warning.id
                 new.inverseBuildServiceWarnings = self
                 new.update(withIssue: warning)
             }
         }
         
         // Errors
         if let errors = issues.errors {
             if let set = self.unresolvedErrors {
                 for issue in set {
                     issue.inverseUnresolvedErrors = nil
                     context.delete(issue)
                 }
             }
             
             if let set = self.resolvedErrors {
                 for issue in set {
                     issue.inverseResolvedErrors = nil
                     context.delete(issue)
                 }
             }
             
             if let set = self.freshErrors {
                 for issue in set {
                     issue.inverseFreshErrors = nil
                     context.delete(issue)
                 }
             }
             
             for unresolvedIssue in errors.unresolvedIssues {
                 let new = Issue(context: context)
                 new.identifier = unresolvedIssue.id
                 new.inverseUnresolvedErrors = self
                 new.update(withIssue: unresolvedIssue)
             }
             
             for resolvedIssue in errors.resolvedIssues {
                 let new = Issue(context: context)
                 new.identifier = resolvedIssue.id
                 new.inverseResolvedErrors = self
                 new.update(withIssue: resolvedIssue)
             }
             
             for freshIssue in errors.freshIssues {
                 let new = Issue(context: context)
                 new.identifier = freshIssue.id
                 new.inverseFreshErrors = self
                 new.update(withIssue: freshIssue)
             }
         }
         
         // Warnings
         if let warnings = issues.warnings {
             if let set = self.unresolvedWarnings {
                 for issue in set {
                     issue.inverseUnresolvedWarnings = nil
                     context.delete(issue)
                 }
             }
             
             if let set = self.resolvedWarnings {
                 for issue in set {
                     issue.inverseResolvedWarnings = nil
                     context.delete(issue)
                 }
             }
             
             if let set = self.freshWarnings {
                 for issue in set {
                     issue.inverseFreshWarnings = nil
                     context.delete(issue)
                 }
             }
             
             for unresolvedIssue in warnings.unresolvedIssues {
                 let new = Issue(context: context)
                 new.identifier = unresolvedIssue.id
                 new.inverseUnresolvedWarnings = self
                 new.update(withIssue: unresolvedIssue)
             }
             
             for resolvedIssue in warnings.resolvedIssues {
                 let new = Issue(context: context)
                 new.identifier = resolvedIssue.id
                 new.inverseResolvedWarnings = self
                 new.update(withIssue: resolvedIssue)
             }
             
             for freshIssue in warnings.freshIssues {
                 let new = Issue(context: context)
                 new.identifier = freshIssue.id
                 new.inverseFreshWarnings = self
                 new.update(withIssue: freshIssue)
             }
         }
         
         // Analyzer Warnings
         if let analyzerWarnings = issues.analyzerWarnings {
             if let set = self.unresolvedAnalyzerWarnings {
                 for issue in set {
                     issue.inverseUnresolvedAnalyzerWarnings = nil
                     context.delete(issue)
                 }
             }
             
             if let set = self.resolvedAnalyzerWarnings {
                 for issue in set {
                     issue.inverseResolvedAnalyzerWarnings = nil
                     context.delete(issue)
                 }
             }
             
             if let set = self.freshAnalyzerWarnings {
                 for issue in set {
                     issue.inverseFreshAnalyzerWarnings = nil
                     context.delete(issue)
                 }
             }
             
             for unresolvedIssue in analyzerWarnings.unresolvedIssues {
                 let new = Issue(context: context)
                 new.identifier = unresolvedIssue.id
                 new.inverseUnresolvedAnalyzerWarnings = self
                 new.update(withIssue: unresolvedIssue)
             }
             
             for resolvedIssue in analyzerWarnings.resolvedIssues {
                 let new = Issue(context: context)
                 new.identifier = resolvedIssue.id
                 new.inverseResolvedAnalyzerWarnings = self
                 new.update(withIssue: resolvedIssue)
             }
             
             for freshIssue in analyzerWarnings.freshIssues {
                 let new = Issue(context: context)
                 new.identifier = freshIssue.id
                 new.inverseFreshAnalyzerWarnings = self
                 new.update(withIssue: freshIssue)
             }
         }
         
         // Test Failures
         if let testFailures = issues.testFailures {
             if let set = self.unresolvedTestFailures {
                 for issue in set {
                     issue.inverseUnresolvedTestFailures = nil
                     context.delete(issue)
                 }
             }
             
             if let set = self.resolvedTestFailures {
                 for issue in set {
                     issue.inverseResolvedTestFailures = nil
                     context.delete(issue)
                 }
             }
             
             if let set = self.freshTestFailures {
                 for issue in set {
                     issue.inverseFreshTestFailures = nil
                     context.delete(issue)
                 }
             }
             
             for unresolvedIssue in testFailures.unresolvedIssues {
                 let new = Issue(context: context)
                 new.identifier = unresolvedIssue.id
                 new.inverseUnresolvedTestFailures = self
                 new.update(withIssue: unresolvedIssue)
             }
             
             for resolvedIssue in testFailures.resolvedIssues {
                 let new = Issue(context: context)
                 new.identifier = resolvedIssue.id
                 new.inverseResolvedTestFailures = self
                 new.update(withIssue: resolvedIssue)
             }
             
             for freshIssue in testFailures.freshIssues {
                 let new = Issue(context: context)
                 new.identifier = freshIssue.id
                 new.inverseFreshTestFailures = self
                 new.update(withIssue: freshIssue)
             }
         }
     }
 }
 */

#endif
