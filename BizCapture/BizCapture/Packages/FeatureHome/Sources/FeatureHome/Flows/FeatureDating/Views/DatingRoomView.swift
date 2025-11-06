//
//  DatingRoomView.swift
//  FeatureHome
//
//  Created by Анна Яцун on 03.11.2025.
//

import SwiftUI
import ComposableArchitecture

public struct DatingRoomView: View {
    public let store: StoreOf<DatingStore>
    
    public init(store: StoreOf<DatingStore>) {
        self.store = store
    }
    
    public var body: some View {
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
