import XCTest
import ComposableArchitecture
@testable import FeatureHome

final class HomeFeatureTests: XCTestCase {
  func testOnAppearLoads() async {
    let store = TestStore(initialState: HomeFeature.State()) { HomeFeature() } withDependencies: {
      $0.homeClient.load = { [HomeEntity(id: 1, title: "OK")] }
    }
    await store.send(.onAppear)
    await store.receive(.loaded([HomeEntity(id: 1, title: "OK")])) {
      $0.isLoading = false
      $0.items = [HomeEntity(id: 1, title: "OK")]
    }
  }
}
