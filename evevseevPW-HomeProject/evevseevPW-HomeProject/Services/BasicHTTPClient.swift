import Foundation

protocol HTTPClient {
    func get(url: URL, onCompletion: @escaping (Result<Data, Error>) -> Void)
}

class BasicHTTPClient: HTTPClient {
    func get(url: URL, onCompletion: @escaping (Result<Data, Error>) -> Void) {
        let urlSession = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
            if let error = error {
                onCompletion(.failure(error))
            }

            if let data = data {
                onCompletion(.success(data))
            }
        }
        urlSession.resume()
    }
}
