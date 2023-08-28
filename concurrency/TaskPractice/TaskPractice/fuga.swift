//
//  TaskPractice
//

import Foundation

struct MypageInfo {
    let friend: [String]
    let articleTitle: [String]
}

struct InternalError: Error {}

// フレンドを取得する
private func fetchFriends() async -> [String] {
    await Util.wait(seconds: 3) // 重い処理ということを擬似的に表現
    return [
        "Droid",
        "Gopher",
        "Pagey",
        "Hoge"
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
// sleep中にキャンセルマークが付いたらCancellationErrorをスローして実際にキャンセルする
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
    await withTaskGroup(of: FetchType.self) { group in // このgroupはTaskGroup型のインスタンス

        // 子タスク作成①
        group.addTask {
            // friendAPIを叩いて名前を取得
            let friends = await fetchFriends()
            print("子タスク①", friends)
            return FetchType.friends(friends)
        }

        // 子タスク作成②
        group.addTask {
            // articlesAPIを叩いて記事名を取得
            let articles = await fetchArticles()
            print("子タスク②", articles)
            return FetchType.articles(articles)
        }

        // ①と②は並列的に実行される

        // 子タスクの結果を取得
        // 2つの子タスクのうち最初に終わったタスク結果を得る
        guard let firstResult = await group.next() else { // nextメソッドで最初に完了した子タスクの結果を取得
            group.cancelAll() // 残りのタスクをキャンセル （※cancelAllしても、子タスク側でキャンセルのチェックをしないと子タスクの処理は続いてしまうので注意）
            return
        }

        switch firstResult {
            case .articles(let a):
                articles = a
            case .friends(let f):
                friends = f
        }

        // 2番目に終わった結果を得る
        guard let secondResult = await group.next() else {
            group.cancelAll()
            return
        }

        switch secondResult {
            case .articles(let a):
                articles = a
            case .friends(let f):
                friends = f
        }
    }

    // 更新されたローカル変数friendsとarticlesを使ってMypageInfoを作成
    return MypageInfo(friend: friends, articleTitle: articles)
}

func fetchFriendStatus(ids: [String]) async -> [String: String?] {
    // fetchFriendStatusが親タスク
    
    // タスクグループを作成する。子タスクの戻り値はタプル
    return await withTaskGroup(of: (String, String?).self) { group in
        for id in ids {
            // ループを回して子タスクを生成
            group.addTask{
                // fetchStatusは非同期関数なので、awaitをつけてプログラムが待機できるようにする
                return (id, await fetchStatus(id: id))
            }
        }
        var status: [String: String?] = [:]
        for await (id, state) in group {
            status[id] = state
        }
        return status
    }
}

// 記事を取得する
private func fetchStatus(id: String) async -> String {
    await Util.wait(seconds: 2)
    return "🤩"
}

// 1秒待ってエラーを返す関数
private func fetchFriendsFromLocalDB() async throws -> [String] {
    await Util.wait(seconds: 1)
    throw InternalError()
}

func fetchAllFriends() async throws -> [String] {
    return try await withThrowingTaskGroup(of: [String].self) { group in // ofには子タスクの戻り値の型を指定
        group.addTask {
            // 3秒かかる
            let friends = await fetchFriends()
            print("3秒かかる子タスク①", friends)
            return friends
        }

        group.addTask {
            // 1秒かかる
            // エラーが発生する
            let friends = try await fetchFriendsFromLocalDB()
            print("1秒でエラーが発生する子タスク②", friends)
            return friends
        }
        // fetchFriendsにキャンセルマークがつき、3秒かかる処理だが3秒待たずに速やかにキャンセルすることで親タスクにすぐエラーを伝播できる


        var allFriends: [String] = []
        // fetchFriendsFromLocalDBのエラーが親タスクのfetchAllFriendsにも伝播する
        for try await friends in group {
            print("親タスクのfor await文", friends)
            allFriends.append(contentsOf: friends)
        }

        return allFriends
    }
}
//
//do {
//    let friends = try await fetchAllFriends()
//    print("呼び出し元成功", friends)
//} catch {
//    print("呼び出し元エラー", error.localizedDescription)
//}

Task.init(operation: .high)
