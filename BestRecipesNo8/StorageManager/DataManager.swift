//
//  DataManager.swift
//  BestRecipesNo8
//
//  Created by Aleksandr Rybachev on 10.09.2023.
//

import Foundation
import UIKit

class DataManager {
    
    static let shared = DataManager()
    
    private init() {}
    
    func createTempData(completion: @escaping () -> Void) {
        
        if !UserDefaults.standard.bool(forKey: "done") {
            
            let firstIngredients = ["sugar": "10kg", "salt": "5gh"]
            let secondIngredients = ["bread": "10 kg", "buter": "honey", "fuck": "you"]
            
            let recipeOne = RecipeInfoRealm(title: "Бургер",
                                            serves: "1",
                                            cookTime: "25 min",
                                            imageData: (UIImage(named: "бургер")?.pngData() ?? Data()),
                                            ingredients: firstIngredients)
            
            
            let recipeTwo = RecipeInfoRealm(title: "Роллы",
                                            serves: "2",
                                            cookTime: "35 min",
                                            imageData: (UIImage(named: "роллы")?.pngData() ?? Data()),
                                            ingredients: secondIngredients)
            
            DispatchQueue.main.async {
                StorageManager.shared.save(recipes: [recipeOne, recipeTwo])
                UserDefaults.standard.set(true, forKey: "done")
                completion()
            }
        }
        
    }
}
