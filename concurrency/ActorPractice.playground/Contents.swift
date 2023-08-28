import Foundation
import PlaygroundSupport
import SwiftUI

actor Score {
    var localLogs: [Int] = []
    private(set) var highScore: Int = 0
    
    func update(with score: Int) async {
        // 処理順を逆にする
        highScore = await requestHighScore(with: score) // ...B
        localLogs.append(score) // ...A
    }
    
    // サーバに点数を送るとサーバが集計した自分の最高得点が得られると想定したメソッド
    // 実際には2秒待って返すだけ
    func requestHighScore(with score: Int) async -> Int {
        try? await Task.sleep(nanoseconds: 2 * NSEC_PER_SEC) // 2秒待つ
        return score
    }
}

let score = Score()
Task.detached {
    await score.update(with: 100) // ...①
    print(await score.localLogs)  // ...①'
    print(await score.highScore)  // ...①''
}

Task.detached {
    await score.update(with: 110) // ...②
    print(await score.localLogs)  // ...②'
    print(await score.highScore)  // ...②''
}
