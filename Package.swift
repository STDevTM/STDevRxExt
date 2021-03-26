// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "STDevRxExt",
    platforms: [
        .macOS(.v10_10), .iOS(.v9), .tvOS(.v9), .watchOS(.v3),
    ],
    products: [
        .library(
            name: "STDevRxExt",
            targets: ["STDevRxExt"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "6.0.0")),
    ],
    targets: [
        .target(
            name: "STDevRxExt",
            dependencies: [
                .product(name: "RxSwift", package: "RxSwift"),
                .product(name: "RxCocoa", package: "RxSwift"),
            ]
        ),
        .testTarget(
            name: "STDevRxExtTests",
            dependencies: [
                "STDevRxExt",
                .product(name: "RxTest", package: "RxSwift")
            ]
        ),
    ],
    swiftLanguageVersions: [.v5]
)
