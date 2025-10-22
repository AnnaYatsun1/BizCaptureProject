//
//  ContentView.swift
//  BizCapture
//
//  Created by Анна Яцун on 29.09.2025.
//

import SwiftUI
import SwiftData
//import CoreModule
//import DocumentsFeature
import ComposableArchitecture


struct ContentView: View {
//    @Environment(\.modelContext) private var modelContext
//    @Query private var items: [Item]

    private var store: StoreOf<ContenViewReducer>
    
    init(store: StoreOf<ContenViewReducer>) {
        self.store = store
    }
    
    var body: some View {
        WithViewStore(store, observe:  \.item) { viewStore in
                    NavigationSplitView {
                        List {
                            ForEach(viewStore.state) { item in
                                NavigationLink {
                                    Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                                } label: {
                                    Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                                }
                            }
                            .onDelete( ) { indexSet in
                                viewStore.send(.edite(indexSet))
                            }
                        }
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                EditButton()
                            }
                            ToolbarItem {
                                Button(action: { viewStore.send(.add) } , label:  { Label("Add Item", systemImage: "plus") })
                            }
                        }
                    } detail: {
                        Text("Select an item")
                    }
        }

    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
//            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
//                modelContext.delete(items[index])
            }
        }
    }
}
//
//#Preview {
//    ContentView()
//        .modelContainer(for: Item.self, inMemory: true)
//}
