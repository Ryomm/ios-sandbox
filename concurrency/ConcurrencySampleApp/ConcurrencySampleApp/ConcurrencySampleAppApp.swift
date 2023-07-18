//
//  ConcurrencySampleAppApp.swift
//  ConcurrencySampleApp
//

import SwiftUI

@main
struct ConcurrencySampleAppApp: App {
    @StateObject private var store = ProgramStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView(programs: $store.programs)
                .task {
                    do {
                        try await store.loadPrograms()
                    } catch {
                        print("try again")
                    }
                }
        }
    }
}
