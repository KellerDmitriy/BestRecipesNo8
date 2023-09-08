//
//  DataManager.swift
//  BestRecipesNo8
//
//  Created by Aleksandr Rybachev on 06.09.2023.
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
            
            let recipe = RecipeInfoRealm(title: "Test recipe",
                                         serves: " 25 tests",
                                         cookTime: "25 test min",
                                         imageData: Data(),
                                         ingredients: firstIngredients)
 
            
            let recipeTwo = RecipeInfoRealm(title: "TWO recipe",
                                            serves: "TWO 25 tests",
                                            cookTime: "TWO 25 test min",
                                            imageData: (UIImage(systemName: "xmark")?.pngData() ?? Data()),
                                            ingredients: secondIngredients)
 
            DispatchQueue.main.async {
                StorageManager.shared.save(recipes: [recipe, recipeTwo])
                UserDefaults.standard.set(true, forKey: "done")
                completion()
            }
        }
        
    }
}
