//
//  ImageManager.swift
//  BestRecipesNo8
//
//  Created by Aleksandr Rybachev on 28.08.2023.
//

import Foundation

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

}
