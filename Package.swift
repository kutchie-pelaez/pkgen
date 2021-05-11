// swift-tools-version:5.3.0

import PackageDescription

let package = Package(
    name: "pkgen",
    platforms: [
        .macOS(.v10_13)
    ],
    products: [
        .executable(
            name: "pkgen",
            targets: [
                "PackageGen"
            ]
        )
    ],
    targets: [
        .target(
            name: "PackageGen",
            dependencies: [

            ]
        )
    ]
)
