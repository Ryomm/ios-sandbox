// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ToDoFeature",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "ToDoFeature",
            targets: ["Tasks"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(name: "Models", dependencies: []),
        .target(name: "Tasks", dependencies: ["Models"])
    ]
)
