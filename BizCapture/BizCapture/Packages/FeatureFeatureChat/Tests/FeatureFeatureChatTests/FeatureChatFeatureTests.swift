import XCTest
import ComposableArchitecture
@testable import FeatureFeatureChat

final class FeatureChatFeatureTests: XCTestCase {
  func testOnAppearLoads() async {
    let store = TestStore(initialState: FeatureChatFeature.State()) { FeatureChatFeature() } withDependencies: {
      $0.featureChatClient.load = { [FeatureChatEntity(id: 1, title: "OK")] }
    }
    await store.send(.onAppear)
    await store.receive(.loaded([FeatureChatEntity(id: 1, title: "OK")])) {
      $0.isLoading = false
      $0.items = [FeatureChatEntity(id: 1, title: "OK")]
    }
  }
}
