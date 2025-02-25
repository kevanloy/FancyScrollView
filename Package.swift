// swift-tools-version:6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FancyScrollView",
    platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "FancyScrollView",
            targets: ["FancyScrollView"]),
    ],
    targets: [
        .target(
            name: "FancyScrollView",
            dependencies: []),
    ]
)
