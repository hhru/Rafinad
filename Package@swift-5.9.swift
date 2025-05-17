// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "Rafinad",
    platforms: [
        .macOS(.v11),
        .iOS(.v15),
        .tvOS(.v15)
    ],
    products: [
        .library(
            name: "Rafinad",
            targets: ["Rafinad"]
        ),
        .library(
            name: "RafinadDynamic",
            type: .dynamic,
            targets: ["Rafinad"]
        ),
        .library(
            name: "RafinadTesting",
            targets: ["RafinadTesting"]
        )
    ],
    targets: [
        .target(
            name: "Rafinad",
            path: "Sources/Accessibility"
        ),
        .target(
            name: "RafinadTesting",
            dependencies: ["Rafinad"],
            path: "Sources/Testing",
            linkerSettings: [.linkedFramework("XCTest")]
        ),
        .testTarget(
            name: "RafinadTests",
            dependencies: [
                "Rafinad",
                "RafinadTesting"
            ],
            path: "Tests",
            exclude: ["Info.plist"]
        )
    ],
    swiftLanguageVersions: [.v5]
)
