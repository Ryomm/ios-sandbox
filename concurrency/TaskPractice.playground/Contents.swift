//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

struct MypageInfo {
    let friend: [String]
    let articleTitle: [String]
    
    // フレンドを取得する
    private func fetchFriends() async -> [String] {
        await Util.wait(seconds: 3) // 重い処理ということを擬似的に表現
        return [
            "Droid",
            "Gopher",
            "Pagey"
        ]
    }

    // 記事を取得する
    private func fetchArticles() async -> [String] {
        await Util.wait(seconds: 1)
        return [
            "猫は本当にかわいい",
            "犬もかわいいぞ",
            "鳥も忘れちゃいけねぇ"
        ]
    }

    // 指定時間タスクをスリープさせて重い処理を表現するためのメソッド
    // キャンセルマークが付いたらCancellationErrorをスローして実際にキャンセルする
    struct Util {
        static func wait(seconds: UInt64) async {
            try? await Task.sleep(nanoseconds: seconds * NSEC_PER_SEC)
        }
    }
    
    func fetchMyPageData() async -> MypageInfo {
        var friends: [String] = []
        var articles: [String] = []

        // 子タスクの型を定義
        enum FetchType {
            case friends([String])
            case articles([String])
        }

        // ofで子タスクが返す型を判定
        await withTaskGroup(of: FetchType.self) { group in

            // 子タスク作成①
            group.addTask { [weak self] in
                // friendAPIを叩いて名前を取得
                let friends = await self?.fetchFriends() ?? []
                return FetchType.friends(friends)
            }

            // 子タスク作成②
            group.addTask { [weak self] in
                // articlesAPIを叩いて記事名を取得
                let articles = await self?.fetchArticles() ?? []
                return FetchType.articles(articles)
            }

            // ①と②は並列的に実行される

            // 子タスクの結果を取得
            // groupインスタンスを通してaddTaskのクロージャ内で返された値を取得できる
            // TaskGroupはfor await inループを使える
            for await fetchResult in group {
                switch fetchResult {
                case .friends(let f):
                    friends = f
                case .articles(let a):
                    articles = a
                }
            }
        }

        // 更新されたローカル変数friendsとarticlesを使ってMypageInfoを作成
        return MypageInfo(friend: friends, articleTitle: articles)
    }
}




