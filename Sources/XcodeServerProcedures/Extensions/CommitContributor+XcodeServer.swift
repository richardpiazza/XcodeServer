import Foundation
import XcodeServerCommon
import XcodeServerAPI
#if canImport(CoreData)
import XcodeServerCoreData

extension CommitContributor {
    public func update(withCommitContributor contributor: XCSCommitContributor) {
        self.name = contributor.name
        self.displayName = contributor.displayName
        if let emails = contributor.emails {
            do {
                self.emailsData = try JSON.jsonEncoder.encode(emails)
            } catch {
                print(error)
            }
        }
    }
}

#endif
