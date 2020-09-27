# XcodeServer

A swift framework for interacting with, and persisting data from an "Xcode Server".

<p>
    <img src="https://github.com/richardpiazza/XcodeServer/workflows/Swift/badge.svg?branch=main" />
    <img src="https://img.shields.io/badge/Swift-5.2-orange.svg" />
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

Provides shared resources for the other packages, this includes:

* Enumerations

* JSON utilities

* Test Hierarchy Definitions

### XcodeServerAPI

All of the DTO definitions for the Xcode Server API. The `APIClient` class provides endpoint definitions and utilities for downloading 
Integration coverage data & assets.

### XcodeServerCoreData

A CoreData (on Apple platforms) driven implementation of primary Xcode Server entities and their relationships to one another.

### XcodeServerProcedures

A operation-driven level that combines the api and persisted storage.

### XcodeServerUtility

A `Manager` class that interacts with the procedures the query and persist data from the server API.

### `xcscli`

The executable `xcscli` provides a command line interface to the Xcode Server API. To execute from the command line (without building a 
binary version), you can use the `swift run` command from the root directory. For instance:

```bash
$ swift run xcscli --help
```

The subcommand include:

#### ping

Performs a HTTP GET on the `/ping` endpoint. Will output 'OK' if successful.

```bash
$ swift run xcscli ping fully.qualified.domain.name
```

#### versions

Performs a HTTP GET on the `/versions` endpoint. This contains versioning information about the API, Operating System, and Installed 
Xcode.

```bash
$ swift run xcscli versions fully.qualified.domain.name
```

#### bots

Performs a HTTP GET on the `/bots` endpoint. Without any additional options this will return a collection of all the Xcode Bots on the 
server. A `--path` option can be specified for additional information. A single Bot is targeted by specifying the `--id` argument.

*Paths:*

* **stats**: General statistics information about a single Bot.

* **integrations**: The last (up to) 10 integrations for the specific Bot.

* **run**: Triggers a new integration for the specific Bot.

#### integrations

Performs a HTTP GET on the `/integrations` endpoint. A unique identifier must be supplied with `--id/-i`. `--path` is available to 
additional resources.

*Paths*:

* **commits**: The source control history leading to the Integration.

* **issues**: Issues that are identified as new/resolved for the Integration.

* **coverage**: Unit testing coverage data (can take a while).

#### sync

On Apple platforms this command will download and persist data from a requested server.

## References

* [Apple's Developer Documentation](https://developer.apple.com/library/archive/documentation/Xcode/Conceptual/XcodeServerAPIReference/index.html)
* [Buildasaurs/XcodeServer-API-Docs](https://github.com/buildasaurs/XcodeServer-API-Docs)
* [Honza Dvorskys Xcode Server Tutorials](https://honzadvorsky.com/pages/xcode_server_tutorials/)
* [API Reference Guide](Documentation/XcodeServerAPIReference.md)
