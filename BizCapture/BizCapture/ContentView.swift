//
//  ContentView.swift
//  BizCapture
//
//  Created by Анна Яцун on 29.09.2025.
//

import SwiftUI
import SwiftData
import Core
//import CoreModule
//import DocumentsFeature
import ComposableArchitecture
import FeatureHome
import FeatureFeatureChat


struct ContentView: View {
    var store: StoreOf<TabsFeature>
    var body: some View {
        ZStack {
          switch store.selected {
          case .home:    HomeView(store: store.scope(state: \.home,    action: \.home))
          case .chat:    ChatView(store: store.scope(state: \.chat,    action: \.chat))
          case .profile: ProfileView(store: store.scope(state: \.profile, action: \.profile))
          }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
        .safeAreaInset(edge: .bottom) {
              GlassTabBar(
                selected: Binding(
                  get: { store.selected },
                  set: { store.send(.setSelected($0)) }
                )
              ).padding(.bottom, 8)
              .ignoresSafeArea(edges: .bottom)
        }
    }
  }

//#Preview {
//    ContentView(store: Store(initialState: TabsFeature.State(), reducer: { TabsFeature() }))
//        .modelContainer(for: Item.self, inMemory: true)
//    
//}
