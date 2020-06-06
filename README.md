# XcodeServer

<p align="center">
    <img src="https://github.com/richardpiazza/XcodeServer/workflows/Swift/badge.svg?branch=master" />
    <img src="https://img.shields.io/badge/Swift-5.2-orange.svg" />
    <a href="https://swift.org/package-manager">
        <img src="https://img.shields.io/badge/swiftpm-compatible-brightgreen.svg?style=flat" alt="Swift Package Manager" />
    </a>
    <a href="https://twitter.com/richardpiazza">
        <img src="https://img.shields.io/badge/twitter-@richardpiazza-blue.svg?style=flat" alt="Twitter: @richardpiazza" />
    </a>
</p>

<p align="center">A swift framework for interacting with, and persisting data from an "Xcode Server".</p>

## Usage

XcodeServer is distributed using the [Swift Package Manager](https://swift.org/package-manager). To install it into a project, add it as a dependency within your `Package.swift` manifest:

```swift
let package = Package(
    ...
    dependencies: [
        .package(url: "https://github.com/richardpiazza/XcodeServer.git", from: "1.0.0-rc.7")
    ],
    ...
)
```

Then import the **XcodeServer** packages wherever you'd like to use it:

```swift
import XcodeServer
```

## Packages

### XcodeServerCommon

### XcodeServerAPI

### XcodeServerCoreData

### XcodeServerProcedures

### XcodeServer

## References

* [Apple's Developer Documentation](https://developer.apple.com/library/archive/documentation/Xcode/Conceptual/XcodeServerAPIReference/index.html)
* [Buildasaurs/XcodeServer-API-Docs](https://github.com/buildasaurs/XcodeServer-API-Docs)
* [Honza Dvorskys Xcode Server Tutorials](https://honzadvorsky.com/pages/xcode_server_tutorials/)
* [API Reference Guide](Documentation/XcodeServerAPIReference.md)
