//
//  FamilyRoomView.swift
//  FeatureHome
//
//  Created by Анна Яцун on 03.11.2025.
//

import SwiftUI
import ComposableArchitecture

public struct FamilyRoomView: View {
    public let store: StoreOf<FamilyStore>
    
    public init(store: StoreOf<FamilyStore>) {
        self.store = store
    }
    
    public var body: some View {
        Text(store.titele)
        VStack {
            Text(store.titele)
            Button(action: {
                store.send(.closeScreen)
            }, label: {
                Text("Close")
            })
        }
    }
}
