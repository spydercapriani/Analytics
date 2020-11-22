// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Analytics",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "Analytics",
            targets: [
                "Analytics"
            ]
        ),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "Analytics",
            dependencies: []
        ),
    ]
)
