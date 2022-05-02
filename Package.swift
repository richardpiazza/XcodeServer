// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "XcodeServer",
    platforms: [
        .macOS(.v12),
        .iOS(.v15),
        .tvOS(.v15),
        .watchOS(.v8),
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "XcodeServer",
            targets: [
                "XcodeServer",
                "XcodeServerAPI",
                "XcodeServerCoreData",
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
        .package(url: "https://github.com/richardpiazza/SessionPlus.git", .upToNextMajor(from: "2.0.1")),
        .package(url: "https://github.com/richardpiazza/CoreDataPlus.git", .upToNextMajor(from: "0.2.0")),
        .package(url: "https://github.com/apple/swift-log.git", .upToNextMajor(from: "1.4.2")),
        .package(url: "https://github.com/apple/swift-argument-parser.git", .upToNextMajor(from: "1.1.1")),
        .package(url: "https://github.com/tsolomko/SWCompression", .upToNextMajor(from: "4.5.5")),
        .package(url: "https://github.com/onevcat/Rainbow", .upToNextMajor(from: "4.0.1")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .executableTarget(
            name: "xcscli",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "Logging", package: "swift-log"),
                "CoreDataPlus",
                "Rainbow",
                "XcodeServerCoreData",
                "XcodeServerAPI",
            ]
        ),
        .target(
            name: "XcodeServer",
            dependencies: []
        ),
        .target(
            name: "XcodeServerAPI",
            dependencies: [
                "SessionPlus",
                "SWCompression",
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
                .product(name: "Logging", package: "swift-log"),
            ],
            resources: [.process("Resources")]
        ),
        .target(
            name: "XcodeServerModel_1_1_0",
            dependencies: [
                "XcodeServer",
                "CoreDataPlus",
                .product(name: "Logging", package: "swift-log"),
            ],
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "XcodeServerTests",
            dependencies: [
                "XcodeServer",
                "XcodeServerAPI",
                "XcodeServerCoreData"
            ],
            resources: [.process("Resources")]
        ),
    ],
    swiftLanguageVersions: [.v5]
)
