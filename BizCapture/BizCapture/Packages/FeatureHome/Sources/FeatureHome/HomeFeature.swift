import Foundation
import ComposableArchitecture
import Core
import SwiftUI
//
//@Reducer
//public struct HomeFeature {
//  @ObservableState
//  public struct State: Equatable {
//    public var isLoading = false
//    public var items: [HomeEntity] = []
//    public init() {}
//  }
//  public enum Action: Equatable { case onAppear, loaded([HomeEntity]), failed(String) }
//  public init() {}
//  @Dependency(\.homeClient) var client
//  public var body: some ReducerOf<Self> {
//      let api = APIClient()
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

public enum Room: String, Equatable, CaseIterable, Identifiable {
  case friend, family, coach, dating
  public var id: String { rawValue }
}


@Reducer
public struct HomeStore {
    
    public init() {
        
    }
    
    @ObservableState
    public struct State: Equatable {
        public var titele: String
        
        @Presents var family: FamilyStore.State?
        @Presents var coach: CoachStore.State?
        @Presents var friend: FriendStore.State?
        @Presents var dating: DatingStore.State?
        
        public init(titele: String = "Home Screen") {
            self.titele = titele
          }
    }
    
    public enum Action: Equatable {
        case baseView
        case show(Room)
        case dating(PresentationAction<DatingStore.Action>)
        case coach(PresentationAction<CoachStore.Action>)
        case friend(PresentationAction<FriendStore.Action>)
        case family(PresentationAction<FamilyStore.Action>)
//        case dating(DatingStore.Action)
    }
    
    public var body: some ReducerOf<Self> {
//        Scope(state: \.family, action: \.family) { FamilyStore() }
//        Scope(state: \.dating, action: \.dating) { DatingStore() }
//        Scope(state: \.coach, action: \.coach) { CoachStore() }
//        Scope(state: \.friend, action: \.friend) { FriendStore() }
      Reduce { state, action in
        switch action {
        case .show(let room):
            switch room {
            case .friend:
                print("Home Friend")
                state.friend = FriendStore.State()
                return .none
            case .family:
                print("Home Family")
                state.family = FamilyStore.State()
                return .none
            case .coach:
                print("Home Coach")
                state.coach = CoachStore.State()
                return .none
            case .dating:
                print("Home Dating")
                state.dating = DatingStore.State()
                return .none
//                state. = DatingStore.State()
            }
        default:
            return .none
       
        }
      }
      .ifLet(\.$dating, action: \.dating) {
          DatingStore()
      }
      .ifLet(\.$family, action: \.family) {
          FamilyStore()
      }
//        
      .ifLet(\.$coach, action: \.coach) {
          CoachStore()
      }
//        
      .ifLet(\.$friend, action: \.friend) {
          FriendStore()
      }
    }
}

//
//@Reducer
//public struct HomeDestination {
//  @Reducer public enum State: Equatable {
//    case friend(FriendStore.State)
//    case family(FamilyStore.State)
//    case coach(CoachStore.State)
//    case dating(DatingStore.State)
//  }
//
//  public enum Action: Equatable {
//    case friend(FriendStore.Action)
//    case family(FamilyStore.Action)
//    case coach(CoachStore.Action)
//    case dating(DatingStore.Action)
//  }
//
//  public var body: some ReducerOf<Self> {
//    Scope(state: /State.friend, action: /Action.friend) { FriendStore() }
//    Scope(state: /State.family, action: /Action.family) { FamilyStore() }
//    Scope(state: /State.coach,  action: /Action.coach)  { CoachStore() }
//    Scope(state: /State.dating, action: /Action.dating) { DatingStore() }
//  }
//}
//
//

public protocol Store {
    
}









