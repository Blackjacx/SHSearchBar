// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SHSearchBar",
    platforms: [
        .iOS(.v10)
    ],
    products: [
        .library(
            name: "SHSearchBar",
            targets: ["SHSearchBar"]
        )
    ],
    targets: [
        .target(
            name: "SHSearchBar",
            path: "Source/Classes"
        )
    ]
)
