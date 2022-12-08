class ShortNote: Codable {
    // TODO: Wait for an reply in chat, maybe it is better to separate view model and data model
    var text: String

    init(text: String) {
        self.text = text
    }
}
