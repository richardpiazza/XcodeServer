import XcodeServer
#if canImport(CoreData)
import CoreData

public extension XcodeServerCoreData.IntegrationIssues {
    func update(_ catalog: XcodeServer.Integration.IssueCatalog, context: NSManagedObjectContext) {
        catalog.buildServiceErrors.forEach({
            let issue: XcodeServerCoreData.Issue
            if let existing = context.issue(withIdentifier: $0.id) {
                issue = existing
            } else {
                issue = Issue(context: context)
            }
            
            issue.update($0, context: context)
            issue.inverseBuildServiceErrors = self
        })
        
        catalog.buildServiceWarnings.forEach({
            let issue: XcodeServerCoreData.Issue
            if let existing = context.issue(withIdentifier: $0.id) {
                issue = existing
            } else {
                issue = Issue(context: context)
            }
            
            issue.update($0, context: context)
            issue.inverseBuildServiceWarnings = self
        })
        
        catalog.errors.freshIssues.forEach({
            let issue: XcodeServerCoreData.Issue
            if let existing = context.issue(withIdentifier: $0.id) {
                issue = existing
            } else {
                issue = Issue(context: context)
            }
            
            issue.update($0, context: context)
            issue.inverseFreshErrors = self
        })
        
        catalog.errors.resolvedIssues.forEach({
            let issue: XcodeServerCoreData.Issue
            if let existing = context.issue(withIdentifier: $0.id) {
                issue = existing
            } else {
                issue = Issue(context: context)
            }
            
            issue.update($0, context: context)
            issue.inverseResolvedErrors = self
        })
        
        catalog.errors.unresolvedIssues.forEach({
            let issue: XcodeServerCoreData.Issue
            if let existing = context.issue(withIdentifier: $0.id) {
                issue = existing
            } else {
                issue = Issue(context: context)
            }
            
            issue.update($0, context: context)
            issue.inverseUnresolvedErrors = self
        })
        
        catalog.warnings.freshIssues.forEach({
            let issue: XcodeServerCoreData.Issue
            if let existing = context.issue(withIdentifier: $0.id) {
                issue = existing
            } else {
                issue = Issue(context: context)
            }
            
            issue.update($0, context: context)
            issue.inverseFreshWarnings = self
        })
        
        catalog.warnings.resolvedIssues.forEach({
            let issue: XcodeServerCoreData.Issue
            if let existing = context.issue(withIdentifier: $0.id) {
                issue = existing
            } else {
                issue = Issue(context: context)
            }
            
            issue.update($0, context: context)
            issue.inverseResolvedWarnings = self
        })
        
        catalog.warnings.unresolvedIssues.forEach({
            let issue: XcodeServerCoreData.Issue
            if let existing = context.issue(withIdentifier: $0.id) {
                issue = existing
            } else {
                issue = Issue(context: context)
            }
            
            issue.update($0, context: context)
            issue.inverseUnresolvedWarnings = self
        })
        
        catalog.analyzerWarnings.freshIssues.forEach({
            let issue: XcodeServerCoreData.Issue
            if let existing = context.issue(withIdentifier: $0.id) {
                issue = existing
            } else {
                issue = Issue(context: context)
            }
            
            issue.update($0, context: context)
            issue.inverseFreshAnalyzerWarnings = self
        })
        
        catalog.analyzerWarnings.resolvedIssues.forEach({
            let issue: XcodeServerCoreData.Issue
            if let existing = context.issue(withIdentifier: $0.id) {
                issue = existing
            } else {
                issue = Issue(context: context)
            }
            
            issue.update($0, context: context)
            issue.inverseResolvedAnalyzerWarnings = self
        })
        
        catalog.analyzerWarnings.unresolvedIssues.forEach({
            let issue: XcodeServerCoreData.Issue
            if let existing = context.issue(withIdentifier: $0.id) {
                issue = existing
            } else {
                issue = Issue(context: context)
            }
            
            issue.update($0, context: context)
            issue.inverseUnresolvedAnalyzerWarnings = self
        })
        
        catalog.testFailures.freshIssues.forEach({
            let issue: XcodeServerCoreData.Issue
            if let existing = context.issue(withIdentifier: $0.id) {
                issue = existing
            } else {
                issue = Issue(context: context)
            }
            
            issue.update($0, context: context)
            issue.inverseFreshTestFailures = self
        })
        
        catalog.testFailures.resolvedIssues.forEach({
            let issue: XcodeServerCoreData.Issue
            if let existing = context.issue(withIdentifier: $0.id) {
                issue = existing
            } else {
                issue = Issue(context: context)
            }
            
            issue.update($0, context: context)
            issue.inverseResolvedTestFailures = self
        })
        
        catalog.testFailures.unresolvedIssues.forEach({
            let issue: XcodeServerCoreData.Issue
            if let existing = context.issue(withIdentifier: $0.id) {
                issue = existing
            } else {
                issue = Issue(context: context)
            }
            
            issue.update($0, context: context)
            issue.inverseUnresolvedTestFailures = self
        })
    }
}
#endif
