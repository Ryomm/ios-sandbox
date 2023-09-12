//
//  AppClipSampleApp.swift
//  AppClipSample
//

import SwiftUI
import Models
import Tasks

@main
struct AppClipSampleApp: App {
    @StateObject private var store = TaskStore()
    
    var body: some Scene {
        WindowGroup {
            TaskView(tasks: $store.tasks)
        }
    }
}
