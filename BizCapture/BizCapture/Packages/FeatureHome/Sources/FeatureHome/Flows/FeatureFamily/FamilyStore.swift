//
//  FamilyStore.swift
//  FeatureHome
//
//  Created by Анна Яцун on 03.11.2025.
//

import ComposableArchitecture

@Reducer
public struct FamilyStore {
    @Dependency(\.dismiss) var dismiss
    
    @ObservableState
    public struct State: Equatable {
        public var titele: String = "FamilyStore Screen"
    }
    
    
    public enum Action: Equatable {
        case load
        case closeScreen
    }

    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            print("Family")
            switch action {
            case .load:
                return .none
            case .closeScreen:
                return .run { send in
                    await self.dismiss()
                }
            }
        }
    }
}
