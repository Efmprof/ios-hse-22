import Foundation

protocol NotesDataBase {
    static func getNotes() throws -> [ShortNote]
    static func saveNotes(_ notes: [ShortNote]) throws
}

enum NotesDataBaseException: Error {
    case saveError
    case getError
}