import Foundation
import CoreData

public extension IntegrationIssues {

    @NSManaged var buildServiceErrors: Set<Issue>?
    @NSManaged var buildServiceWarnings: Set<Issue>?
    @NSManaged var freshAnalyzerWarnings: Set<Issue>?
    @NSManaged var freshErrors: Set<Issue>?
    @NSManaged var freshTestFailures: Set<Issue>?
    @NSManaged var freshWarnings: Set<Issue>?
    @NSManaged var integration: Integration?
    @NSManaged var resolvedAnalyzerWarnings: Set<Issue>?
    @NSManaged var resolvedErrors: Set<Issue>?
    @NSManaged var resolvedTestFailures: Set<Issue>?
    @NSManaged var resolvedWarnings: Set<Issue>?
    @NSManaged var unresolvedAnalyzerWarnings: Set<Issue>?
    @NSManaged var unresolvedErrors: Set<Issue>?
    @NSManaged var unresolvedTestFailures: Set<Issue>?
    @NSManaged var unresolvedWarnings: Set<Issue>?

}
