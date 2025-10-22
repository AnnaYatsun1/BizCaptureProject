import SwiftUI
import ComposableArchitecture

public struct HomeView: View {
  let store: StoreOf<HomeFeature>
  public init(store: StoreOf<HomeFeature>) { self.store = store }
  public var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      List(viewStore.items) { item in
        HStack { Text(item.title); Spacer(); Text("#\(item.id)") }
      }
      .overlay { if viewStore.isLoading { ProgressView() } }
      .onAppear { viewStore.send(.onAppear) }
      .navigationTitle("Home")
    }
  }
}
