//
//  GitHubService.swift
//  GitHub Profile App
//
//  Created by Lalana Thanthirigama on 2025-04-04.
//

import Foundation
import Combine

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case httpError(Int)
    case decodingError
    case unknown
}

class GitHubService {
    private let baseURL = "https://api.github.com"
    private let session = URLSession.shared
    private let cacheManager = UserCacheManager.shared
    
    func fetchUser(username: String) -> AnyPublisher<User, Error> {
        if let cachedUser = cacheManager.getUser(for: username) {
            return Just(cachedUser)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        guard let url = URL(string: "\(baseURL)/users/\(username)") else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        
        return makeRequest(url: url)
            .handleEvents(receiveOutput: { [weak self] user in
                self?.cacheManager.cacheUser(user)
            })
            .eraseToAnyPublisher()
    }
    
    func fetchFollowers(username: String) -> AnyPublisher<[User], Error> {
        guard let url = URL(string: "\(baseURL)/users/\(username)/followers") else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        return makeRequest(url: url)
    }
    
    func fetchFollowing(username: String) -> AnyPublisher<[User], Error> {
        guard let url = URL(string: "\(baseURL)/users/\(username)/following") else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        return makeRequest(url: url)
    }
    
    func invalidateCache(for username: String) {
        cacheManager.invalidateCache(for: username)
    }
    
    private func makeRequest<T: Decodable>(url: URL) -> AnyPublisher<T, Error> {
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        return session.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NetworkError.invalidResponse
                }
                
                if httpResponse.statusCode == 404 {
                    throw NetworkError.httpError(404)
                }
                
                if !(200...299).contains(httpResponse.statusCode) {
                    throw NetworkError.httpError(httpResponse.statusCode)
                }
                
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                if let decodingError = error as? DecodingError {
                    print("Decoding error: \(decodingError)")
                    return NetworkError.decodingError
                }
                return error
            }
            .eraseToAnyPublisher()
    }
}
