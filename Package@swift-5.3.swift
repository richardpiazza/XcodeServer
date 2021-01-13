// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "XcodeServer",
    platforms: [
        .macOS(.v10_14),
        .iOS(.v12),
        .tvOS(.v12),
        .watchOS(.v5),
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "XcodeServer",
            targets: [
                "XcodeServer",
                "XcodeServerAPI",
                "XcodeServerCoreData",
                "XcodeServerProcedures",
                "XcodeServerUtility"
            ]
        ),
        .executable(
            name: "xcscli",
            targets: ["xcscli"]
        ),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/tsolomko/SWCompression", .upToNextMinor(from: "4.5.5")),
        .package(url: "https://github.com/richardpiazza/ProcedureKit.git", from: "6.0.0-beta.1"),
        .package(url: "https://github.com/richardpiazza/SessionPlus.git", .upToNextMinor(from: "1.0.0")),
        .package(url: "https://github.com/swift-server/async-http-client", from: "1.2.1"),
        .package(url: "https://github.com/apple/swift-argument-parser.git", .upToNextMinor(from: "0.3.1")),
        .package(url: "https://github.com/richardpiazza/CoreDataPlus.git", .upToNextMinor(from: "0.1.1")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "xcscli",
            dependencies: [
                "XcodeServerUtility",
                "XcodeServerCoreData",
                "CoreDataPlus",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ]
        ),
        .target(
            name: "XcodeServer",
            dependencies: []
        ),
        .target(
            name: "XcodeServerAPI",
            dependencies: [
                "SWCompression",
                .product(name: "SessionPlus", package: "SessionPlus", condition: .when(platforms: [.macOS, .iOS, .tvOS, .watchOS])),
                .product(name: "AsyncHTTPClient", package: "async-http-client", condition: .when(platforms: [.linux, .android, .windows])),
            ]
        ),
        .target(
            name: "XcodeServerCoreData",
            dependencies: [
                "XcodeServer",
                "CoreDataPlus",
                "XcodeServerModel_1_0_0",
                "XcodeServerModel_1_1_0",
            ]
        ),
        .target(
            name: "XcodeServerModel_1_0_0",
            dependencies: [
                "XcodeServer",
                "CoreDataPlus",
            ],
            resources: [.process("Resources")]
        ),
        .target(
            name: "XcodeServerModel_1_1_0",
            dependencies: [
                "XcodeServer",
                "CoreDataPlus",
            ],
            resources: [.process("Resources")]
        ),
        .target(
            name: "XcodeServerProcedures",
            dependencies: ["XcodeServer", "ProcedureKit"]
        ),
        .target(
            name: "XcodeServerUtility",
            dependencies: ["XcodeServer", "XcodeServerAPI", "XcodeServerProcedures"]
        ),
        .testTarget(
            name: "XcodeServerTests",
            dependencies: [
                "XcodeServer",
                "XcodeServerAPI",
                "XcodeServerCoreData",
                "XcodeServerUtility"
            ],
            resources: [.process("Resources")]
        ),
    ],
    swiftLanguageVersions: [.v5]
)
