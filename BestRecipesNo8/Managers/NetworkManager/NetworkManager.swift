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
    /// - Returns: Parameters in [String: String]
    private func makeParameters(for endpoint: Endpoint, with query: String?) -> [String: String] {
        var parameters = [String: String]()
        parameters["apiKey"] = API.apiKey
        
        switch endpoint {
        case .getRandomRecipes:
            parameters["number"] = "10"
        case .searchRecipes:
            if query != nil { parameters["query"] = query }
            parameters["number"] = "10"
        case .getPopularRecipes:
            parameters["sort"] = "popularity"
            parameters["number"] = "10"
        case .getRecipesForMealType(type: let type):
            parameters["type"] = type
        case .getRecipeInfoBulk(idRecipes: let ids):
            parameters["ids"] = ids.map { "\($0)" }.joined(separator: ",")
        default:
            break
        }
        
        return parameters
    }
    
    /// Method for making task
    private func makeTask<T: Codable>(for url: URL, using session: URLSession = .shared, completion: @escaping(Result<T, NetworkError>) -> Void) {
        
        session.dataTask(with: url) { data, _, error in
            
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
                //print(decodeData)
            } catch {
                completion(.failure(.decodingError(error)))
            }
        }.resume()
    }
    
    /// Method for making task
    private func makeTask(for url: URL, using session: URLSession = .shared, completion: @escaping(Result<SearchResult, NetworkError>) -> Void) {
        
        session.dataTask(with: url) { data, _, error in
            
            if let error = error {
                completion(.failure(.transportError(error)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decodeData = try JSONDecoder().decode(SearchResult.self, from: data)
                completion(.success(decodeData))
            } catch {
                completion(.failure(.decodingError(error)))
            }
        }.resume()
    }
    
    
    
    // MARK: - Public methods
    
    /// Get random recipes.
    /// - Returns: 10 random recipes
    func getRandomRecipes(completion: @escaping(Result<RandomRecipe, NetworkError>) -> Void) {
        guard let url = createURL(for: .getRandomRecipes, with: nil) else { return }
        makeTask(for: url, completion: completion)
        print(url)
    }
    
    /// Search through thousands of recipes using advanced filtering and ranking.
    /// - Parameters:
    /// - query: The (natural language) recipe search query. If you need result with query you have to use it.
    /// - Returns: 10 recipes as requested
    func getSearchRecipes(for query: String? = nil, completion: @escaping(Result<SearchResult, NetworkError>) -> Void) {
        guard let url = createURL(for: .searchRecipes, with: query) else { return }
        makeTask(for: url, completion: completion)
    }

    /// Get recipe information
    /// - Parameters:
    /// - id: The id of the recipe.
    /// - Returns: Information about a specific recipe
    func getRecipeInformation(for id: Int, completion: @escaping(Result<RecipeInfo, NetworkError>) -> Void) {
        guard let url = createURL(for: .getRecipeInfo(id: id)) else { return }
        makeTask(for: url, completion: completion)
    }
    
    /// Get popular recipes
    /// - Returns: 10 popular recipes
    func getPopularRecipes(completion: @escaping(Result<SearchResult, NetworkError>) -> Void) {
        guard let url = createURL(for: .getPopularRecipes) else { return }
        makeTask(for: url, completion: completion)
    }
    
    /// Get recipes for meal type
    /// - Parameters:
    /// - mealType: The type of recipe.
    /// - Returns: 10 recipes for meal type
    func getRecipesWithMealType(for mealType: String, completion: @escaping(Result<SearchResult, NetworkError>) -> Void) {
        let mealTypeWithUnderscore = mealType.replacingOccurrences(of: " ", with: "_")
        guard let url = createURL(for: .getRecipesForMealType(type: mealTypeWithUnderscore)) else { return }
        makeTask(for: url, completion: completion)
    }
    
    /// Get recipe information bulk
    /// - Parameters:
    /// - ids: A comma-separated list of recipe ids.
    /// - Returns: Get information about multiple recipes at once. This is equivalent to calling the Get Recipe Information endpoint multiple times, but faster.
    func getRecipeInformationBulk(for ids: [Int], completion: @escaping(Result<[RecipeInfo], NetworkError>) -> Void) {
        guard let url = createURL(for: .getRecipeInfoBulk(idRecipes: ids)) else { return }
        print("url bulk: \(url)")
        makeTask(for: url, completion: completion)
    }
    
}

// MARK: NEW METHODS

extension NetworkManager {
    
    /// Get popular recipes
    /// - Returns: 10 popular recipes
    func getTenPopularRecipes(completion: @escaping(Result<[RecipeInfo], NetworkError>) -> Void) {
        guard let url = createURL(for: .getPopularRecipes) else { return }
        
        makeTask(for: url) { searchResult in
            switch searchResult {
            case .success(let data):
                let ids = data.results?.compactMap { $0.id }
                if let ids = ids {
                    getRecipeInformationBulk(for: ids, completion: completion)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    /// Get recipes for meal type
    /// - Parameters:
    /// - mealType: The type of recipe.
    /// - Returns: 10 recipes for meal type
    func getTenRecipesWithMealType(for mealType: String, completion: @escaping(Result<[RecipeInfo], NetworkError>) -> Void) {
        let mealTypeWithUnderscore = mealType.replacingOccurrences(of: " ", with: "_")
        guard let url = createURL(for: .getRecipesForMealType(type: mealTypeWithUnderscore)) else { return }
        
        makeTask(for: url) { searchResult in
            switch searchResult {
            case .success(let data):
                let ids = data.results?.compactMap { $0.id }
                if let ids = ids {
                    getRecipeInformationBulk(for: ids, completion: completion)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}


