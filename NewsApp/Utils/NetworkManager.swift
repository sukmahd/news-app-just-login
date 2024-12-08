//
//  NetworkManager.swift
//  NewsApp
//
//  Created by Sukmo Ronggo Hadi Wijoyo on 09/12/24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case serverError(Int)
    case unknown
}

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func request<T: Codable>(url: URL?, expecting: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = url else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.unknown))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            switch httpResponse.statusCode {
            case 200...299:
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(expecting, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(NetworkError.decodingError))
                }
            case 400...499, 500...599:
                completion(.failure(NetworkError.serverError(httpResponse.statusCode)))
            default:
                completion(.failure(NetworkError.unknown))
            }
        }
        
        task.resume()
    }
}
