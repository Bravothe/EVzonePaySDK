// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "EVzonePaySDK",
    platforms: [
        .iOS(.v16) // Target iOS 16+ for SwiftUI and Combine
    ],
    products: [
        .library(
            name: "EVzonePaySDK",
            targets: ["EVzonePaySDK"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "EVzonePaySDK",
            dependencies: []),
        .testTarget(
            name: "EVzonePaySDKTests",
            dependencies: ["EVzonePaySDK"]),
    ]
)
