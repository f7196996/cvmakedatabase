// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DataPackage",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "DataPackage", targets: ["DataPackage"])
    ],
    targets: [
        .target(name: "DataPackage", dependencies: [], path: "DataPackage", resources: [.copy("JinTonikCD.xcdatamodel")])
    ]
)
