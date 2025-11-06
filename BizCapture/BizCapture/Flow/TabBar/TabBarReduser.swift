//
//  TabBarReduser.swift
//  BizCapture
//
//  Created by Анна Яцун on 29.10.2025.
//

import ComposableArchitecture
import SwiftUICore
import FeatureHome
import FeatureFeatureChat


import ComposableArchitecture

@Reducer
struct TabsFeature {
    
    
  @ObservableState
    struct State: Equatable {
        
    var selected: ModelTabBar = .home

    var home    = HomeStore.State()
    var chat    = ChatStore.State()
    var profile = ProfileStore.State()
  }

  enum Action: Equatable {
    case setSelected(ModelTabBar)        
    case home(HomeStore.Action)
    case chat(ChatStore.Action)
    case profile(ProfileStore.Action)
  }
    
    var body: some ReducerOf<Self> {
      Scope(state: \.home, action: \.home) { HomeStore() }
      Scope(state: \.chat, action: \.chat) { ChatStore() }
      Scope(state: \.profile, action: \.profile) { ProfileStore() }
      Reduce { state, action in
        switch action {
        case .setSelected(let tab):
          state.selected = tab
          return .none
        case .chat, .profile, .home:
          return .none
        }
      }
    }
}



//@Reducer
//struct TabBarStore {
//    typealias State = TabBarState
//    typealias Action = TabBarAction
//    
//    enum TabBarAction: Equatable, BindableAction {
//        case binding(BindingAction<State>)
//        case homeAction(HomeStore.Action)
//        case chatAction(ChatStore.Action)
//        case profileAction(ProfileStore.Action)
//    
//    }
//    
//    @ObservableState
//    struct TabBarState {
//        @BindingState var selected: ModelTabBar = .home
//        var homeState = HomeStore.State()
//        var chatState = ChatStore.State()
//        var profileState = ProfileStore.State()
//    }
//    
//    var body: some ReducerOf<Self> {
//        BindingReducer()
//        
//        Scope(state: \.homeState,    action: \.homeAction)    { HomeStore() }
//        Scope(state: \.chatState,    action: \.chatAction)    { ChatStore() }
//        Scope(state: \.profileState, action: \.profileAction) { ProfileStore() }
//        
//        Reduce { state, action in
//          switch action {
//          case .binding:               return .none
//          case .homeAction, .chatAction, .profileAction: return .none
//          }
//        }
//    }
//
//}
//
//@Reducer
//struct HomeStore {
//    
//    @ObservableState
//    struct State: Equatable {
//        var titele: String = "Home Screen"
//    }
//    
//    enum Action: Equatable {
//        case baseView
//        case fammily
//        case dating
//        case co
//    }
//}
//
//struct FirstView: View {
//    let store: StoreOf<HomeStore>
//    
//    init(store: StoreOf<HomeStore>) {
//        self.store = store
//    }
//    
//    var body: some View {
//        Text(store.titele)
//    }
//}
//
//
//
