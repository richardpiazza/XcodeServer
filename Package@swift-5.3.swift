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
            targets: ["XcodeServer"]),
        .executable(
            name: "xcscli",
            targets: ["xcscli"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/richardpiazza/SessionPlus.git", from: "1.0.0-rc.2"),
        .package(url: "https://github.com/tsolomko/SWCompression", .upToNextMinor(from: "4.5.5")),
        .package(url: "https://github.com/ProcedureKit/ProcedureKit.git", .branch("feature/cross-platform")),
        .package(url: "https://github.com/apple/swift-argument-parser.git", .upToNextMinor(from: "0.1.0")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "xcscli",
            dependencies: [
                "XcodeServer",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ]),
        .target(
            name: "XcodeServer",
            dependencies: ["XcodeServerCommon", "XcodeServerAPI", "XcodeServerCoreData", "XcodeServerProcedures"]),
        .target(
            name: "XcodeServerCommon",
            dependencies: []),
        .target(
            name: "XcodeServerAPI",
            dependencies: ["SWCompression", "SessionPlus"]),
        .target(
            name: "XcodeServerCoreData",
            dependencies: ["XcodeServerCommon"],
            resources: [.process("Resources")]),
        .target(
            name: "XcodeServerProcedures",
            dependencies: ["XcodeServerCommon", "XcodeServerAPI", "XcodeServerCoreData", "ProcedureKit"]),
        .testTarget(
            name: "XcodeServerTests",
            dependencies: ["XcodeServer", "XcodeServerCommon", "XcodeServerAPI", "XcodeServerCoreData"],
            resources: [.process("Resources")]),
    ],
    swiftLanguageVersions: [.v5]
)
