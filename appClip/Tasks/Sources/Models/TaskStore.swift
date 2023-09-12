//
//  TaskStore.swift
//  AppClipSampleApp
//

import Foundation

@MainActor
public class TaskStore: ObservableObject {
    @Published public var tasks: [Task] = []
    
    public init(tasks: [Task] = []) {
        self.tasks = tasks
    }
}
