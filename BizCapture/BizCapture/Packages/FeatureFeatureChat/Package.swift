// swift-tools-version: 5.10
import PackageDescription

let package = Package(
  name: "FeatureFeatureChat",
  platforms: [.iOS(.v17)],
  products: [
    .library(name: "FeatureFeatureChat", targets: ["FeatureFeatureChat"])
  ],
  dependencies: [
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.10.0")
  ],
  targets: [
    .target(
      name: "FeatureFeatureChat",
      dependencies: [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
      ],
      path: "Sources/FeatureFeatureChat"
    ),
    .testTarget(
      name: "FeatureFeatureChatTests",
      dependencies: ["FeatureFeatureChat"],
      path: "Tests/FeatureFeatureChatTests"
    )
  ]
)
