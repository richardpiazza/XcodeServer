// swift-tools-version:5.0
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
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/richardpiazza/CodeQuickKit.git", .branch("develop")),
        .package(url: "https://github.com/tsolomko/BitByteData.git", from: "1.4.0"),
        .package(url: "https://github.com/ProcedureKit/ProcedureKit", .upToNextMinor(from: "5.2.0")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "XcodeServer",
            dependencies: ["XcodeServerCommon", "XcodeServerAPI", "XcodeServerCoreData", "XcodeServerProcedures"]),
        .target(
            name: "XcodeServerCommon",
            dependencies: []),
        .target(
            name: "XcodeServerAPI",
            dependencies: ["XcodeServerCommon", "SWCompression", "CodeQuickKit"]),
        .target(
            name: "XcodeServerCoreData",
            dependencies: ["XcodeServerCommon"]),
        .target(
            name: "XcodeServerProcedures",
            dependencies: ["XcodeServerCommon", "XcodeServerAPI", "XcodeServerCoreData", "ProcedureKit"]),
        .target(
            name: "SWCompression",
            dependencies: ["BitByteData"]),
        .testTarget(
            name: "XcodeServerTests",
            dependencies: ["XcodeServer", "XcodeServerCommon", "XcodeServerAPI", "XcodeServerCoreData"]),
    ],
    swiftLanguageVersions: [.v5]
)
