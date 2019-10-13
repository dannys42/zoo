// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "Shared",
    products: [
        .library(name: "Shared", targets: ["Shared"]),
    ],
    targets: [
        .target(name: "Shared", dependencies: [], path: "Sources")
    ],
    swiftLanguageVersions: [.v4_2, .version("5")]
)
