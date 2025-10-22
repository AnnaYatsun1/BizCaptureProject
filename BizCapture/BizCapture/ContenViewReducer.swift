//
//  ContenViewReducer.swift
//  BizCapture
//
//  Created by Анна Яцун on 02.10.2025.
//

import ComposableArchitecture
import Foundation

@Reducer
struct ContenViewReducer {
    func reduce(into state: inout State, action: Action) -> ComposableArchitecture.Effect<Action> {
        switch action {
        case .add:
            let newItem = Item(timestamp: Date())
            state.item.insert(newItem, at: state.item.count)
            print("Add new item \(newItem.timestamp)")
            return .none
        case let .edite(indexSet):
            state.item.remove(atOffsets: indexSet)
            return .none
        }
    }
    @ObservableState
    struct State: Equatable  {
        public var item: [Item] = []
    }
    
    enum Action {
    case add
    case edite(IndexSet)
    
    }

}
