# XcodeServer

A swift framework for interacting with, and persisting data from an "Xcode Server".

<p>
    <img src="https://github.com/richardpiazza/XcodeServer/workflows/Swift/badge.svg?branch=main" />
    <img src="https://img.shields.io/badge/Swift-5.5-orange.svg" />
    <a href="https://twitter.com/richardpiazza">
        <img src="https://img.shields.io/badge/twitter-@richardpiazza-blue.svg?style=flat" alt="Twitter: @richardpiazza" />
    </a>
</p>

## Installation

This software is distributed using [Swift Package Manager](https://swift.org/package-manager). 
You can add it using Xcode or by listing it as a dependency in your `Package.swift` manifest:

```swift
let package = Package(
  ...
  dependencies: [
    .package(url: "https://github.com/richardpiazza/XcodeServer.git", .upToNextMajor(from: "3.0.0")
  ],
  ...
  targets: [
    .target(
      name: "MyPackage",
      dependencies: [
        "XcodeServer"
      ]
    )
  ]
)
```

## Prerequisites

### macOS, iOS, tvOS, watchOS

none

### Linux (Ubuntu)

**zlib1g-dev** must be pre-installed.
`sudo apt-get install -y zlib1g-dev`

## Usage

### XcodeServer

Core module that provides a unified model representing an Xcode Server and all related entities.

### XcodeServerAPI

All of the DTO definitions for the Xcode Server API. The `XCSClient` class provides endpoint definitions and utilities for 
interacting with an Xcode Server API as well as downloading Integration coverage data & assets.

### XcodeServerCoreData

A CoreData (on Apple platforms) driven implementation of primary Xcode Server entities and their relationships to one another.

### [`xcscli`](Documentation/xcscli.md)

The executable `xcscli` provides a command line interface to the Xcode Server API. To execute from the command line (without building a 
binary version), you can use the `swift run` command from the root directory. For instance:

```bash
$ swift run xcscli --help
```

## Contribution

Contributions are welcomed and encouraged! See the [Contribution Guide](CONTRIBUTING.md) for more information.

## References

* [Apple's Developer Documentation](https://developer.apple.com/library/archive/documentation/Xcode/Conceptual/XcodeServerAPIReference/index.html)
* [Buildasaurs/XcodeServer-API-Docs](https://github.com/buildasaurs/XcodeServer-API-Docs)
* [Honza Dvorskys Xcode Server Tutorials](https://honzadvorsky.com/pages/xcode_server_tutorials/)
* [API Reference Guide](Documentation/XcodeServerAPIReference.md)
* [Tips & Tricks](Documentation/TipsAndTricks.md)
