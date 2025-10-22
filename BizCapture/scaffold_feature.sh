#
//  scaffold_feature.sh
//  BizCapture
//
//  Created by Анна Яцун on 22.10.2025.
//

#!/usr/bin/env bash
set -euo pipefail

# Usage: ./scaffold_feature.sh Home

FEATURE_RAW="${1:-}"
if [[ -z "${FEATURE_RAW}" ]]; then
  echo "Usage: $0 <FeatureName>" >&2; exit 1
fi

# --- helpers ---
sanitize() { echo "$1" | sed -E 's/[^A-Za-z0-9]+//g'; }
lower1() { awk '{ print tolower(substr($0,1,1)) substr($0,2) }'; }

FEATURE_CAMEL="$(sanitize "${FEATURE_RAW}")"          # Home
FEATURE_VAR="$(echo "${FEATURE_CAMEL}" | lower1)"     # home
FEATURE_PKG="Feature${FEATURE_CAMEL}"                 # FeatureHome

# КЛЮЧЕВОЕ: базой делаем директорию, где лежит сам скрипт
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PACKAGES_DIR="${SCRIPT_DIR}/Packages"
PKG_DIR="${PACKAGES_DIR}/${FEATURE_PKG}"

mkdir -p "${PKG_DIR}/Sources/${FEATURE_PKG}/Models" "${PKG_DIR}/Tests/${FEATURE_PKG}Tests"

# Package.swift (изолированный: только TCA)
cat > "${PKG_DIR}/Package.swift" <<EOF
// swift-tools-version: 5.10
import PackageDescription

let package = Package(
  name: "${FEATURE_PKG}",
  platforms: [.iOS(.v17)],
  products: [
    .library(name: "${FEATURE_PKG}", targets: ["${FEATURE_PKG}"])
  ],
  dependencies: [
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.10.0")
  ],
  targets: [
    .target(
      name: "${FEATURE_PKG}",
      dependencies: [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
      ],
      path: "Sources/${FEATURE_PKG}"
    ),
    .testTarget(
      name: "${FEATURE_PKG}Tests",
      dependencies: ["${FEATURE_PKG}"],
      path: "Tests/${FEATURE_PKG}Tests"
    )
  ]
)
EOF

# Reducer
cat > "${PKG_DIR}/Sources/${FEATURE_PKG}/${FEATURE_CAMEL}Feature.swift" <<EOF
import Foundation
import ComposableArchitecture

@Reducer
public struct ${FEATURE_CAMEL}Feature {
  @ObservableState
  public struct State: Equatable {
    public var isLoading = false
    public var items: [${FEATURE_CAMEL}Entity] = []
    public init() {}
  }
  public enum Action: Equatable { case onAppear, loaded([${FEATURE_CAMEL}Entity]), failed(String) }
  public init() {}
  @Dependency(\.${FEATURE_VAR}Client) var client
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .onAppear:
        state.isLoading = true
        return .run { send in
          do { let list = try await client.load(); await send(.loaded(list)) }
          catch { await send(.failed(String(describing: error))) }
        }
      case let .loaded(list): state.isLoading = false; state.items = list; return .none
      case .failed:           state.isLoading = false; return .none
      }
    }
  }
}
EOF

# View
cat > "${PKG_DIR}/Sources/${FEATURE_PKG}/${FEATURE_CAMEL}View.swift" <<EOF
import SwiftUI
import ComposableArchitecture

public struct ${FEATURE_CAMEL}View: View {
  let store: StoreOf<${FEATURE_CAMEL}Feature>
  public init(store: StoreOf<${FEATURE_CAMEL}Feature>) { self.store = store }
  public var body: some View {
    WithViewStore(store, observe: { \$0 }) { viewStore in
      List(viewStore.items) { item in
        HStack { Text(item.title); Spacer(); Text("#\\(item.id)") }
      }
      .overlay { if viewStore.isLoading { ProgressView() } }
      .onAppear { viewStore.send(.onAppear) }
      .navigationTitle("${FEATURE_CAMEL}")
    }
  }
}
EOF

# Client
cat > "${PKG_DIR}/Sources/${FEATURE_PKG}/${FEATURE_CAMEL}Client.swift" <<EOF
import Foundation
import ComposableArchitecture

public struct ${FEATURE_CAMEL}Client {
  public var load: @Sendable () async throws -> [${FEATURE_CAMEL}Entity]
  public init(load: @escaping @Sendable () async throws -> [${FEATURE_CAMEL}Entity]) { self.load = load }
}
private enum ${FEATURE_CAMEL}ClientKey: DependencyKey {
  static let liveValue   = ${FEATURE_CAMEL}Client { try await Task.sleep(nanoseconds: 150_000_000); return [${FEATURE_CAMEL}Entity(id: 1, title: "${FEATURE_CAMEL} #1")] }
  static let testValue   = ${FEATURE_CAMEL}Client { [] }
  static let previewValue= ${FEATURE_CAMEL}Client { [${FEATURE_CAMEL}Entity(id: 42, title: "Preview")] }
}
public extension DependencyValues {
  var ${FEATURE_VAR}Client: ${FEATURE_CAMEL}Client {
    get { self[${FEATURE_CAMEL}ClientKey.self] }
    set { self[${FEATURE_CAMEL}ClientKey.self] = newValue }
  }
}
EOF

# Entity
cat > "${PKG_DIR}/Sources/${FEATURE_PKG}/Models/${FEATURE_CAMEL}Entity.swift" <<EOF
import Foundation
public struct ${FEATURE_CAMEL}Entity: Identifiable, Equatable, Sendable {
  public let id: Int
  public var title: String
  public init(id: Int, title: String) { self.id = id; self.title = title }
}
EOF

# Test
cat > "${PKG_DIR}/Tests/${FEATURE_PKG}Tests/${FEATURE_CAMEL}FeatureTests.swift" <<EOF
import XCTest
import ComposableArchitecture
@testable import ${FEATURE_PKG}

final class ${FEATURE_CAMEL}FeatureTests: XCTestCase {
  func testOnAppearLoads() async {
    let store = TestStore(initialState: ${FEATURE_CAMEL}Feature.State()) { ${FEATURE_CAMEL}Feature() } withDependencies: {
      \$0.${FEATURE_VAR}Client.load = { [${FEATURE_CAMEL}Entity(id: 1, title: "OK")] }
    }
    await store.send(.onAppear)
    await store.receive(.loaded([${FEATURE_CAMEL}Entity(id: 1, title: "OK")])) {
      \$0.isLoading = false
      \$0.items = [${FEATURE_CAMEL}Entity(id: 1, title: "OK")]
    }
  }
}
EOF

echo "✅ Created ${FEATURE_PKG} at ${PKG_DIR}"
echo "👉 Xcode: File → Add Packages… → Add Local… → ${PKG_DIR}"
