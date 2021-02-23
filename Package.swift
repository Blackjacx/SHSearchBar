// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "SHSearchBar",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v10)
    ],
    products: [
        .library(name: "SHSearchBar", targets: ["SHSearchBar"])
    ],
    dependencies: [
        .package(name: "Quick", url: "https://github.com/Quick/Quick", from: "3.1.2"),
        .package(name: "Nimble", url: "https://github.com/Quick/Nimble", from: "9.0.0")
    ],
    targets: [
        .target(name: "SHSearchBar", resources: [.process("Resources")]),
        .testTarget(name: "SHSearchBarTests", dependencies: ["SHSearchBar", "Quick", "Nimble"])
    ]
)
