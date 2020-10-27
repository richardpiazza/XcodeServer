# XcodeServer

A swift framework for interacting with, and persisting data from an "Xcode Server".

<p>
    <img src="https://github.com/richardpiazza/XcodeServer/workflows/Swift/badge.svg?branch=main" />
    <img src="https://img.shields.io/badge/Swift-5.3-orange.svg" />
    <a href="https://twitter.com/richardpiazza">
        <img src="https://img.shields.io/badge/twitter-@richardpiazza-blue.svg?style=flat" alt="Twitter: @richardpiazza" />
    </a>
</p>

## Usage

XcodeServer is distributed using the [Swift Package Manager](https://swift.org/package-manager). To install it into a project, add it as a 
dependency within your `Package.swift` manifest:

```swift
let package = Package(
    ...
    dependencies: [
        .package(url: "https://github.com/richardpiazza/XcodeServer.git", .upToNextMinor(from: "1.1.0")
    ],
    ...
)
```

Then import the **XcodeServer** packages wherever you'd like to use it:

```swift
import XcodeServer
```

## Prerequisites

### macOS, iOS, tvOS, watchOS

none

### Linux (Ubuntu)

**zlib1g-dev** must be pre-installed.
`sudo apt-get install -y zlib1g-dev`

## Packages

### XcodeServer

Core module that provides a unified model representing an Xcode Server and all related entities.


### XcodeServerAPI

All of the DTO definitions for the Xcode Server API. The `APIClient` class provides endpoint definitions and utilities for downloading
Integration coverage data & assets.

### XcodeServerCoreData

A CoreData (on Apple platforms) driven implementation of primary Xcode Server entities and their relationships to one another.

### XcodeServerProcedures

A operation-driven level that combines the api and persisted storage.

### XcodeServerUtility

A `Manager` class that interacts with the procedures the query and persist data from the server API.

### [`xcscli`](Documentation/xcscli.md)

The executable `xcscli` provides a command line interface to the Xcode Server API. To execute from the command line (without building a 
binary version), you can use the `swift run` command from the root directory. For instance:

```bash
$ swift run xcscli --help
```

## References

* [Apple's Developer Documentation](https://developer.apple.com/library/archive/documentation/Xcode/Conceptual/XcodeServerAPIReference/index.html)
* [Buildasaurs/XcodeServer-API-Docs](https://github.com/buildasaurs/XcodeServer-API-Docs)
* [Honza Dvorskys Xcode Server Tutorials](https://honzadvorsky.com/pages/xcode_server_tutorials/)
* [API Reference Guide](Documentation/XcodeServerAPIReference.md)
* [Tips & Tricks](Documentation/TipsAndTricks.md)
