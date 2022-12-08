import Foundation

class NewsRepository {
    static func fetchNews() -> [News] {
        return [News(title: "ABCD", description: "OMG"), News(title: "123", description: "lllllooolll")]
    }
}
