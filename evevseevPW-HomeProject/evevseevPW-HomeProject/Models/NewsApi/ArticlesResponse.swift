struct ArticlesResponse: Decodable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}


