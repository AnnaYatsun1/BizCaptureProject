// swift-tools-version: 5.10
import PackageDescription

let package = Package(
  name: "FeatureHome",
  platforms: [.iOS(.v17)],
  products: [
    .library(name: "FeatureHome", targets: ["FeatureHome"])
  ],
  dependencies: [
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.10.0")
  ],
  targets: [
    .target(
      name: "FeatureHome",
      dependencies: [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
      ],
      path: "Sources/FeatureHome"
    ),
    .testTarget(
      name: "FeatureHomeTests",
      dependencies: ["FeatureHome"],
      path: "Tests/FeatureHomeTests"
    )
  ]
)
