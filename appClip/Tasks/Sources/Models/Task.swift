//
//  Task.swift
//  AppClipSampleApp
//

import Foundation

public struct Task: Identifiable, Codable {
    public let id: UUID
    public var title: String
    public var isDone: Bool
    
    public init(id: UUID = UUID(), title: String, isDone: Bool = false) {
        self.id = id
        self.title = title
        self.isDone = isDone
    }
}

extension Task {
    public static var emptyTask: Task {
        Task(title: "")
    }
}

extension Task {
    public static let sampleData: [Task] = [
        Task(title: "Hoge"),
        Task(title: "Fuga", isDone: true),
        Task(title: "Nuga")
    ]
}
