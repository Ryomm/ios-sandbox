// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SampleModule",
    products: [
        .library(
            name: "AppFeature",
            targets: ["FeatureA"]
        ),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "FeatureA",
            dependencies: ["FeatureB"]
        ),
        .target(
            name: "FeatureB",
            dependencies: []
        ),
    ]
)
