import Foundation

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


