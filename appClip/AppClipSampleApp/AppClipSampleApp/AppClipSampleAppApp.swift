//
//  AppClipSampleAppApp.swift
//  AppClipSampleApp
//

import SwiftUI

@main
struct AppClipSampleAppApp: App {
    @StateObject private var store = TaskStore()
    
    var body: some Scene {
        WindowGroup {
            TaskView(tasks: $store.tasks)
        }
    }
}
