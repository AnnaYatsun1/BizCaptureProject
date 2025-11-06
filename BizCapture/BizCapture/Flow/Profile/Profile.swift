//
//  Profile.swift
//  BizCapture
//
//  Created by Анна Яцун on 29.10.2025.
//
import ComposableArchitecture

import SwiftUI
@Reducer
struct ProfileStore {
    
    @ObservableState
    struct State: Equatable {
        var titele: String = "Profile Screen"
    }
    
    enum Action: Equatable {
        case profile
    }
   
}

struct ProfileView: View {
    
    let store: StoreOf<ProfileStore>
    
    init(store: StoreOf<ProfileStore>) {
        self.store = store
    }
    
    
    var body: some View {
        Text(store.titele)
    }
}
