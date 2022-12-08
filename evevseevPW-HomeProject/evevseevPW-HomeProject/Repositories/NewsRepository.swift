import Foundation

protocol NewsRepository {
    func getTopHeadlines(onCompletion: @escaping (Result<[ArticleViewModel], Error>) -> Void) -> Void
}

class APINewsProvider: NewsRepository {
    private let client: HTTPClient = BasicHTTPClient()

    func getTopHeadlines(onCompletion: @escaping (Result<[ArticleViewModel], Error>) -> Void) {
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=26fe41e5f9e94241be60ff9bfa8bd9a1") else {
            return
        }

        client.get(url: url) { result in
            switch result {
            case .success(let data):
                do {
                    let response = try JSONDecoder().decode(ArticlesResponse.self, from: data)
                    let news = response.articles.compactMap {
                        ArticleViewModel(title: $0.title, description: $0.description, imageUrl: URL(string: $0.urlToImage ?? ""))
                    }
                    onCompletion(.success(news))
                } catch let error {
                    onCompletion(.failure(error))
                }

                break
            case .failure(let error):
                onCompletion(.failure(error))
                break
            }
        }
    }
}
