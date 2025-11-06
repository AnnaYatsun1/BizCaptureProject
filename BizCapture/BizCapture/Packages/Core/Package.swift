// swift-tools-version: 5.9
import PackageDescription

// swift-tools-version: 5.9
import PackageDescription

let package = Package(
  name: "CoreSPM",
  platforms: [.iOS(.v17)],
  products: [
    .library(name: "Core", targets: ["Core"]),
    .library(name: "DesignSystem", targets: ["DesignSystem"]),
    .library(name: "NetworkingKit", targets: ["NetworkingKit"]) // опционально
  ],
  dependencies: [
    .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.2.0"),
//    .package(url: "https://github.com/SimplyDanny/SwiftLintPlugins", .upToNextMinor(from: "0.55.1")),
//    .package(url: "https://github.com/realm/SwiftLint.git", .upToNextMinor(from: "0.55.1")),  Xcode 15 / Swift 5.10
    // для Xcode 16 можно поднять до .upToNextMinor(from: "0.62.2")
   // .package(url: "https://github.com/nicklockwood/SwiftFormat.git", .upToNextMinor(from: "0.53.0")),
  ],
  targets: [
    .target(
      name: "NetworkingKit",
      dependencies: [
        .product(name: "Dependencies", package: "swift-dependencies")
      ],
      path: "Sources/NetworkingKit"
    ),
    .target(
      name: "DesignSystem",
      dependencies: [
        .product(name: "Dependencies", package: "swift-dependencies")
      ],
      path: "Sources/DesignSystem",
      resources: [.process("Resources")]
    ),
    
    .target(
      name: "Core",
      dependencies: [
        "NetworkingKit",
        "DesignSystem",
        .product(name: "Dependencies", package: "swift-dependencies")
      ],
      path: "Sources/Core"
    ),
  ]
)

