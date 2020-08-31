// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "SHSearchBar",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v10)
    ],
    products: [
        .library(name: "SHSearchBar", targets: ["SHSearchBar-iOS"])
    ],
    dependencies: [
        .package(name: "Quick", url: "https://github.com/Quick/Quick", from: "3.0.0"),
        .package(name: "Nimble", url: "https://github.com/Quick/Nimble", from: "8.1.1")
    ],
    targets: [
        .target(name: "SHSearchBar-iOS", path: "Source"),
        .testTarget(name: "SHSearchBar_iOS_Tests", dependencies: ["Quick", "Nimble"])
    ],
    swiftLanguageVersions: [.v5]
)