import UIKit

struct Article: Codable {
    var title: String
    var user: User

    struct User: Codable {
        var name: String
    }
}

func request(to url: URL) async throws -> [Article] {
    let (data, _) = try await URLSession.shared.data(from: url, delegate: nil)

    let articles = try JSONDecoder().decode([Article].self, from: data)
    return articles
}

var isLoading = true
Task.detached {
    do {
        let url = URL(string: "https://qiita.com/api/v2/items")!
        let response = try await request(to: url)
        isLoading = false
        print(response)
    } catch {
        isLoading = false
        print(error.localizedDescription)
    }
}

