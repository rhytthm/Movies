//
//  Networkable.swift
//  Movies
//
//  Created by RAJEEV MAHAJAN on 26/02/25.
//

import Foundation

protocol Networkable {
    func sendRequest<T: Decodable>(endpoint: RequestObject, completion: @escaping ((Result<T, Error>) -> Void))
}

enum NetworkError: Error {
    case invalidURL
    case invalidResponse(error: String)
    
}

public final class NetworkManager: Networkable {
    private init() {}
    public static let shared = NetworkManager()
    func sendRequest<T: Decodable>(endpoint: RequestObject, completion: @escaping ((Result<T, Error>) -> Void)) {
        guard let urlRequest = makeRequest(endpoint: endpoint) else {
            print("Invalid URL Request")
            return
        }
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                print(error?.localizedDescription as Any)
                return completion(.failure(NetworkError.invalidResponse(error: error?.localizedDescription ?? "Unknown Error")))
            }
            guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                return completion(.failure(NetworkError.invalidResponse(error: "No proper response")))
            }
            guard let data = data else {
                return completion(.failure(NetworkError.invalidResponse(error: "No Data")))
            }
            let decoder = JSONDecoder()
            do {
                let response = try decoder.decode(T.self, from: data)
                return completion(.success(response))
            } catch {
                
            }
        }
        task.resume()
    }
}

extension NetworkManager {
    fileprivate func makeRequest(endpoint: RequestObject) -> URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.baseUrl
        urlComponents.path = endpoint.path
        if let queryParams = endpoint.queryParams {
            urlComponents.queryItems = queryParams.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        guard let url = urlComponents.url else { fatalError("Invalid URL") }
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = endpoint.headers
        request.httpMethod = endpoint.method.rawValue
        request.timeoutInterval = 60
        if let bodyParams = endpoint.bodyParams {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: bodyParams)
            } catch {
                print("Failed to encode body parameters")
            }
        }
        return request
    }
}
