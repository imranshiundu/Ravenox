// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "RavenoxKit",
    platforms: [
        .iOS(.v18),
        .macOS(.v15),
    ],
    products: [
        .library(name: "RavenoxProtocol", targets: ["RavenoxProtocol"]),
        .library(name: "RavenoxKit", targets: ["RavenoxKit"]),
        .library(name: "RavenoxChatUI", targets: ["RavenoxChatUI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/steipete/ElevenLabsKit", exact: "0.1.0"),
        .package(url: "https://github.com/gonzalezreal/textual", exact: "0.3.1"),
    ],
    targets: [
        .target(
            name: "RavenoxProtocol",
            path: "Sources/RavenoxProtocol",
            swiftSettings: [
                .enableUpcomingFeature("StrictConcurrency"),
            ]),
        .target(
            name: "RavenoxKit",
            dependencies: [
                "RavenoxProtocol",
                .product(name: "ElevenLabsKit", package: "ElevenLabsKit"),
            ],
            path: "Sources/RavenoxKit",
            resources: [
                .process("Resources"),
            ],
            swiftSettings: [
                .enableUpcomingFeature("StrictConcurrency"),
            ]),
        .target(
            name: "RavenoxChatUI",
            dependencies: [
                "RavenoxKit",
                .product(
                    name: "Textual",
                    package: "textual",
                    condition: .when(platforms: [.macOS, .iOS])),
            ],
            path: "Sources/RavenoxChatUI",
            swiftSettings: [
                .enableUpcomingFeature("StrictConcurrency"),
            ]),
        .testTarget(
            name: "RavenoxKitTests",
            dependencies: ["RavenoxKit", "RavenoxChatUI"],
            path: "Tests/RavenoxKitTests",
            swiftSettings: [
                .enableUpcomingFeature("StrictConcurrency"),
                .enableExperimentalFeature("SwiftTesting"),
            ]),
    ])
