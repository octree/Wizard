// swift-tools-version:5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Wizard",
    platforms: [
        .macOS(.v10_14),
        .iOS(.v10),
    ],
    products: [
        .library(
            name: "Wizard",
            targets: ["Wizard"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "Wizard",
            dependencies: [],
            resources: [
                .process("Resources")
            ]),
        .testTarget(
            name: "WizardTests",
            dependencies: ["Wizard"]),
    ])
