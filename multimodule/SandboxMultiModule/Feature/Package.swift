// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AppFeature",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "Home", targets: ["Home"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-numerics", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "Home",
            dependencies: [
                "Graph",
                "FunctionForm",
                "Models",
            ]
        ),
        .target(
            name: "Graph",
            dependencies: [
                .product(name: "Numerics", package: "swift-numerics"),
                "Models"
            ]
        ),
        .target(
            name: "FunctionForm",
            dependencies: [
                "Models"
            ]
        ),
        .target(
            name: "Models",
            dependencies: [
                .product(name: "Numerics", package: "swift-numerics"),
            ]
        ),
    ]
)
