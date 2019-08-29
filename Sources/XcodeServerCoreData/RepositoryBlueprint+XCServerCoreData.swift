import Foundation
import XcodeServerAPI

extension XCSRepositoryBlueprint {
    var repositoryIds: [String] {
        var ids = [String]()
        if let keys = self.locations?.keys.sorted() {
            ids.append(contentsOf: keys)
        }
        return ids
    }
}
