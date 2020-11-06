import XcodeServer
import Foundation

extension Integration {
    /// Indicates wether the _.xcarchive_ has been previously retrieved for this `Integration`.
    ///
    /// The archive only become available after the integration completes.
    var shouldRetrieveArchive: Bool {
        guard step == .completed else {
            return false
        }
        
        return true
    }
    
    /// Indicates wether _Commits_ have been previously retrieved for this `Integration`.
    ///
    /// Commits could _not_ be available for the integration, and if detected, this flag should indicate false.
    var shouldRetrieveCommits: Bool {
        guard step == .completed else {
            return false
        }
        
        return (commits ?? []).isEmpty
    }
    
    /// Indicates wether _Issues_ have been previously retrieved for this `Integration`.
    ///
    /// Issues only become available after the integration completes.
    var shouldRetrieveIssues: Bool {
        guard step == .completed else {
            return false
        }
        
        return (issues?.allIssues ?? []).isEmpty
    }
}
