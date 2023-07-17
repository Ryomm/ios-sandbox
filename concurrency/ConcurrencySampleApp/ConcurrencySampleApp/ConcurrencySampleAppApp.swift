//
//  ConcurrencySampleAppApp.swift
//  ConcurrencySampleApp
//

import SwiftUI

@main
struct ConcurrencySampleAppApp: App {
    @State private var programs = Program.sampleData
    var body: some Scene {
        WindowGroup {
            ContentView(programs: $programs)
        }
    }
}
