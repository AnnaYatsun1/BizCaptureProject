import Foundation
import ComposableArchitecture
import Core

@Reducer
public struct HomeFeature {
  @ObservableState
  public struct State: Equatable {
    public var isLoading = false
    public var items: [HomeEntity] = []
    public init() {}
  }
  public enum Action: Equatable { case onAppear, loaded([HomeEntity]), failed(String) }
  public init() {}
  @Dependency(\.homeClient) var client
  public var body: some ReducerOf<Self> {
      let api = APIClient()
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
