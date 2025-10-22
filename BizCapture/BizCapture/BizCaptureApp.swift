//
//  BizCaptureApp.swift
//  BizCapture
//
//  Created by Анна Яцун on 29.09.2025.
//

import SwiftUI
import SwiftData
import ComposableArchitecture
import Core

@main
struct BizCaptureApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        let api = APIClient()
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView(store: Store(initialState: ContenViewReducer.State(item: []), reducer: { ContenViewReducer() }))
        }
        .modelContainer(sharedModelContainer)
    }
}
