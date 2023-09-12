//
//  Task.swift
//  AppClipSampleApp
//

import Foundation

struct Task: Identifiable, Codable {
    let id: UUID
    var title: String
    var isDone: Bool
    
    init(id: UUID = UUID(), title: String, isDone: Bool = false) {
        self.id = id
        self.title = title
        self.isDone = isDone
    }
}

extension Task {
    static var emptyTask: Task {
        Task(title: "")
    }
}

extension Task {
    static let sampleData: [Task] = [
        Task(title: "Hoge"),
        Task(title: "Fuga", isDone: true),
        Task(title: "Nuga")
    ]
}
