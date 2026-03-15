// swift-tools-version: 6.2
// Package manifest for the Ravenox macOS companion (menu bar app + IPC library).

import PackageDescription

let package = Package(
    name: "Ravenox",
    platforms: [
        .macOS(.v15),
    ],
    products: [
        .library(name: "RavenoxIPC", targets: ["RavenoxIPC"]),
        .library(name: "RavenoxDiscovery", targets: ["RavenoxDiscovery"]),
        .executable(name: "Ravenox", targets: ["Ravenox"]),
        .executable(name: .ravenox-mac", targets: ["RavenoxMacCLI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/orchetect/MenuBarExtraAccess", exact: "1.2.2"),
        .package(url: "https://github.com/swiftlang/swift-subprocess.git", from: "0.1.0"),
        .package(url: "https://github.com/apple/swift-log.git", from: "1.8.0"),
        .package(url: "https://github.com/sparkle-project/Sparkle", from: "2.8.1"),
        .package(url: "https://github.com/steipete/Peekaboo.git", branch: "main"),
        .package(path: "../shared/RavenoxKit"),
        .package(path: "../../Swabble"),
    ],
    targets: [
        .target(
            name: "RavenoxIPC",
            dependencies: [],
            swiftSettings: [
                .enableUpcomingFeature("StrictConcurrency"),
            ]),
        .target(
            name: "RavenoxDiscovery",
            dependencies: [
                .product(name: "RavenoxKit", package: "RavenoxKit"),
            ],
            path: "Sources/RavenoxDiscovery",
            swiftSettings: [
                .enableUpcomingFeature("StrictConcurrency"),
            ]),
        .executableTarget(
            name: "Ravenox",
            dependencies: [
                "RavenoxIPC",
                "RavenoxDiscovery",
                .product(name: "RavenoxKit", package: "RavenoxKit"),
                .product(name: "RavenoxChatUI", package: "RavenoxKit"),
                .product(name: "RavenoxProtocol", package: "RavenoxKit"),
                .product(name: "SwabbleKit", package: "swabble"),
                .product(name: "MenuBarExtraAccess", package: "MenuBarExtraAccess"),
                .product(name: "Subprocess", package: "swift-subprocess"),
                .product(name: "Logging", package: "swift-log"),
                .product(name: "Sparkle", package: "Sparkle"),
                .product(name: "PeekabooBridge", package: "Peekaboo"),
                .product(name: "PeekabooAutomationKit", package: "Peekaboo"),
            ],
            exclude: [
                "Resources/Info.plist",
            ],
            resources: [
                .copy("Resources/Ravenox.icns"),
                .copy("Resources/DeviceModels"),
            ],
            swiftSettings: [
                .enableUpcomingFeature("StrictConcurrency"),
            ]),
        .executableTarget(
            name: "RavenoxMacCLI",
            dependencies: [
                "RavenoxDiscovery",
                .product(name: "RavenoxKit", package: "RavenoxKit"),
                .product(name: "RavenoxProtocol", package: "RavenoxKit"),
            ],
            path: "Sources/RavenoxMacCLI",
            swiftSettings: [
                .enableUpcomingFeature("StrictConcurrency"),
            ]),
        .testTarget(
            name: "RavenoxIPCTests",
            dependencies: [
                "RavenoxIPC",
                "Ravenox",
                "RavenoxDiscovery",
                .product(name: "RavenoxProtocol", package: "RavenoxKit"),
                .product(name: "SwabbleKit", package: "swabble"),
            ],
            swiftSettings: [
                .enableUpcomingFeature("StrictConcurrency"),
                .enableExperimentalFeature("SwiftTesting"),
            ]),
    ])
