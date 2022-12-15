// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "InBrainSurveys",
    platforms: [.macCatalyst(.v13),
                .iOS(.v12)],
    products: [.library(name: "InBrainSurveys",
                        targets: ["InBrainSurveys"]),
    ],
    targets: [
        .binaryTarget(
            name: "InBrainSurveys",
            path: "InBrainSurveys.xcframework"
        ),
    ]
)
