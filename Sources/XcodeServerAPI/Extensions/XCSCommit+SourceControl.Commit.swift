import XcodeServer

extension Array where Element == XCSCommit {
    func commits(forIntegration id: Integration.ID? = nil) -> [SourceControl.Commit] {
        var commits: [SourceControl.Commit] = []
        self.forEach { (xcsCommit) in
            xcsCommit.commits?.forEach({ (key, value) in
                let remote = key
                commits.append(contentsOf: value.commits(remote: remote, integration: id))
            })
        }
        
        return commits
    }
}

extension Array where Element == XCSRepositoryCommit {
    func commits(remote: SourceControl.Remote.ID? = nil, integration: Integration.ID?) -> [SourceControl.Commit] {
        return map({
            let remote = remote ?? $0.repositoryID
            return SourceControl.Commit($0, remote: remote, integration: integration)
        })
    }
}
