import Foundation
import ComposableArchitecture

//@Reducer
//public struct FeatureChatFeature {
//  @ObservableState
//  public struct State: Equatable {
//    public var isLoading = false
//    public var items: [FeatureChatEntity] = []
//    public init() {}
//  }
//  public enum Action: Equatable { case onAppear, loaded([FeatureChatEntity]), failed(String) }
//  public init() {}
//  @Dependency(\.featureChatClient) var client
//  public var body: some ReducerOf<Self> {
//    Reduce { state, action in
//      switch action {
//      case .onAppear:
//        state.isLoading = true
//        return .run { send in
//          do { let list = try await client.load(); await send(.loaded(list)) }
//          catch { await send(.failed(String(describing: error))) }
//        }
//      case let .loaded(list): state.isLoading = false; state.items = list; return .none
//      case .failed:           state.isLoading = false; return .none
//      }
//    }
//  }
//}



@Reducer
public struct ChatStore {
    
    public init() {
        
    }
    
    @ObservableState
    public struct State: Equatable {
        public var titele: String
        
        public init(titele: String = "Chat Screen") {
            self.titele = titele
          }
    }
    
    public enum Action: Equatable {
        case onAppear, loaded, failed(String)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in .none }
      }
}
