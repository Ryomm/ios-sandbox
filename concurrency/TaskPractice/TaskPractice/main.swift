//
//  hoge.swift
//  TaskPractice
//
//

import Foundation

func fetchDataWithLongTask() async throws -> [String] {
    return try await withThrowingTaskGroup(of: [String].self) { group in
        group.addTask {
                    // キャンセルチェック
                    // タスクがキャンセルのマークされていたら実際にキャンセルする
                    try Task.checkCancellation()
                    
                    // とても重い処理
                    await superLongTask()
                    return [
                        "Droid",
                        "Gopher",
                        "Pagey"
                    ]
                }

                        // 明示的にキャンセルを行う
                        group.cancelAll()
                        return []
            
    }
}

private func superLongTask() async -> [String] {
    await Util.wait(seconds: 10)
    return [
        "Hoge",
        "Fuga"
    ]
}

let hoge = try await fetchDataWithLongTask()
print(hoge)
