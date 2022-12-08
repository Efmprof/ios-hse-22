import Foundation

class ArticleViewModel {
    let title: String
    let description: String
    let imageUrl: URL?
    var imageData: Data? = nil

    init(title: String, description: String, imageUrl: URL? = nil) {
        self.title = title;
        self.description = description;
        self.imageUrl = imageUrl;
    }
}

