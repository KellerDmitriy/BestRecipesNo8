//
//  NetworkManager.swift
//  BestRecipesNo8
//
//  Created by Aleksandr Rybachev on 28.08.2023.
//

import Foundation

enum NetworkError: Error {
    case transportError(Error)
    case serverError(statusCode: Int)
    case noData
    case decodingError(Error)
}

struct NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    // MARK: - Private Methods
    
    /// Create URL for API method
    private func createURL(for endPoint: Endpoint, with query: String? = nil) -> URL? {
        var components = URLComponents()
        components.scheme = API.scheme
        components.host = API.host
        components.path = endPoint.path
        
        components.queryItems = makeParameters(for: endPoint, with: query).compactMap {
            URLQueryItem(name: $0.key, value: $0.value)
        }
        
        return components.url
    }
    
    /// Make dictionary of parameters for URL request
    private func makeParameters(for endpoint: Endpoint, with query: String?) -> [String: String] {
        var parameters = [String: String]()
        parameters["apiKey"] = API.apiKey
        
        switch endpoint {
        case .getRandomRecipes:
            parameters["number"] = "10"
        case .searchRecipes:
            if query != nil {
                parameters["query"] = query
            }
        default:
            break
        }
        
        return parameters
    }
    
    /// Method for making task
    private func makeTask<T: Codable>(for url: URL, using session: URLSession = .shared, completion: @escaping(Result<T, NetworkError>) -> Void) {
        
        let task = session.dataTask(with: url) { data, _, error in
            
            if let error = error {
                completion(.failure(.transportError(error)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decodeData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodeData))
                print(decodeData)
            } catch {
                completion(.failure(.decodingError(error)))
            }
        }
        
        task.resume()
    }
    
    // MARK: - Public methods
    
    /// Get random recipes
    /// - Returns: Several random recipes
    func getRandomRecipes(completion: @escaping(Result<RandomRecipe, NetworkError>) -> Void) {
        
        guard let url = createURL(for: .getRandomRecipes, with: nil) else { return }
        
        makeTask(for: url, completion: completion)
        
    }
    
    /// Search recipes
    /// - Parameters: If you need result with query you have to use it.
    /// - Returns: Multiple recipes as requested
    func getSearchRecipes(for query: String? = nil, completion: @escaping(Result<SearchResult, NetworkError>) -> Void) {
        
        guard let url = createURL(for: .searchRecipes, with: query) else { return }
        
        makeTask(for: url, completion: completion)
    }
    
    /// Get recipe information
    /// - Returns: Information about a specific recipe
    func getRecipeInformation(for id: Int, completion: @escaping(Result<RecipeInfo, NetworkError>) -> Void) {
        
        guard let url = createURL(for: .getRecipeInfo(id: id)) else { return }
        
        makeTask(for: url, completion: completion)
    }
    
}
