//
//  ImageManager.swift
//  BestRecipesNo8
//
//  Created by Aleksandr Rybachev on 28.08.2023.
//

import UIKit

class ImageManager {
    
    static let shared = ImageManager()
    
    private init() {}
    
    func fetchImageData(from url: URL?, completion: @escaping(Data, URLResponse) -> Void) {
        guard let url = url else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response else {
                print(error?.localizedDescription ?? "No discription")
                return
            }
            
            guard url == response.url else { return }
            
            DispatchQueue.main.async {
                completion(data, response)
            }
        }.resume()
    }
    
    func fetchImageData(from url: URL?) -> Data? {
        guard let url = url else { return nil }
        guard let imageData = try? Data(contentsOf: url) else { return nil }
        return imageData
    }
    
    func saveDataToCache(with data: Data, and response: URLResponse) {
        guard let url = response.url else { return }
        let request = URLRequest(url: url)
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: request)
    }
    
    func getCachedImage(from url: URL) -> UIImage? {
        let request = URLRequest(url: url)
        if let cachedResponse = URLCache.shared.cachedResponse(for: request) {
            return UIImage(data: cachedResponse.data)
        }
        return nil
    }

}
