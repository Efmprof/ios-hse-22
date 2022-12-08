import Foundation

// TODO: find the best way to separate protocols in different files. For now it will stay here
protocol NotesDataBase {
    static func getNotes() throws -> [ShortNote]
    static func saveNotes(_ notes: [ShortNote]) throws
}

enum NotesDataBaseException: Error {
    case saveError
    case getError
}

class UserDefaultsStorage: NotesDataBase {
    private static let NOTES_STORAGE_KEY = "Notes"

    static func getNotes() throws -> [ShortNote] {
        if let data = UserDefaults.standard.data(forKey: NOTES_STORAGE_KEY) {
            do {
                let decoder = JSONDecoder()
                return try decoder.decode([ShortNote].self, from: data)
            } catch {
                throw NotesDataBaseException.getError
            }
        } else {
            return []
        }
    }

    static func saveNotes(_ notes: [ShortNote]) throws {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(notes)
            UserDefaults.standard.set(data, forKey: NOTES_STORAGE_KEY)
        } catch {
            throw NotesDataBaseException.saveError
        }
    }
}


