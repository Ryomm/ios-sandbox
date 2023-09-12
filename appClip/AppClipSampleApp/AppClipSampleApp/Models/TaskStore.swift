//
//  TaskStore.swift
//  AppClipSampleApp
//

import Foundation

@MainActor
class TaskStore: ObservableObject {
    @Published var tasks: [Task] = []
}
