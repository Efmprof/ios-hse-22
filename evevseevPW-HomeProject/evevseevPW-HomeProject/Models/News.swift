import Foundation

class News {
    let title: String
    let description: String
    let imageUrl: URL?
    // add getters and setters?
    var imageData: Data? = nil

    init(title: String, description: String, imageUrl: URL? = nil) {
        self.title = title;
        self.description = description;
        self.imageUrl = imageUrl;
    }
}

