// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "Shared",
    products: [
        .library(name: "Shared", targets: ["Shared"]),
    ],
    dependencies: [
        .package(url: "https://github.com/onevcat/Rainbow", from: "3.0.0"),
    ],
    targets: [
        .target(name: "Shared", dependencies: ["Rainbow"], path: "Sources")
    ],
    swiftLanguageVersions: [.v4_2, .version("5")]
)
