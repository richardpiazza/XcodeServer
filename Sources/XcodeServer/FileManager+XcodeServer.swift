import Foundation

public extension FileManager {
    var xcodeServerDirectory: URL {
        let folder = "XcodeServer"
        let root: URL
        do {
            #if os(tvOS)
            root = try url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            #else
            root = try url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            #endif
            
            return root.appendingPathComponent(folder, isDirectory: true)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
