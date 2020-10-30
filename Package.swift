// swift-tools-version:5.2
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
            targets: ["XcodeServer", "XcodeServerAPI", "XcodeServerCoreData", "XcodeServerProcedures", "XcodeServerUtility"]),
        .executable(
            name: "xcscli",
            targets: ["xcscli"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/tsolomko/SWCompression", .upToNextMinor(from: "4.5.5")),
        .package(url: "https://github.com/richardpiazza/ProcedureKit.git", .branch("feature/cross-platform")),
        .package(url: "https://github.com/swift-server/async-http-client", from: "1.2.1"),
        .package(url: "https://github.com/apple/swift-argument-parser.git", .upToNextMinor(from: "0.1.0")),
        .package(url: "https://github.com/apple/swift-tools-support-core.git", .upToNextMinor(from: "0.1.10")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "xcscli",
            dependencies: [
                "XcodeServerUtility",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "SwiftToolsSupport", package: "swift-tools-support-core"),
            ]),
        .target(
            name: "XcodeServer",
            dependencies: []),
        .target(
            name: "XcodeServerAPI",
            dependencies: [
                "XcodeServer",
                "SWCompression",
                .product(name: "AsyncHTTPClient", package: "async-http-client"),
            ]),
        .target(
            name: "XcodeServerCoreData",
            dependencies: ["XcodeServer"]),
        .target(
            name: "XcodeServerProcedures",
            dependencies: ["XcodeServer", "ProcedureKit"]),
        .target(
            name: "XcodeServerUtility",
            dependencies: ["XcodeServer", "XcodeServerAPI", "XcodeServerCoreData", "XcodeServerProcedures"]),
        .testTarget(
            name: "XcodeServerTests",
            dependencies: ["XcodeServer", "XcodeServerAPI", "XcodeServerCoreData", "XcodeServerUtility"]),
    ],
    swiftLanguageVersions: [.v5]
)
