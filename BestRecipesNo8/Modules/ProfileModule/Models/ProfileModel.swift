//
//  ProfileModel.swift
//  BestRecipesNo8
//
//  Created by Мявкo on 1.09.23.
//

import UIKit
import RealmSwift

struct CreatedRecipeModel {
    let recipeImage: UIImage?
    let rating: Double
    let recipeName: String
    let countIngredients: Int
    let timeCooking: String
    
    init(recipeInfoRealm: RecipeInfoRealm) {
        // Преобразуйте данные из RecipeInfoRealm в формат CreatedRecipeModel
        if let image = UIImage(data: recipeInfoRealm.imageData) {
            self.recipeImage = image
        } else {
            self.recipeImage = nil
        }
        self.rating = 5
        self.recipeName = recipeInfoRealm.title
        self.countIngredients = recipeInfoRealm.ingredients.count
        self.timeCooking = recipeInfoRealm.cookTime
    }
}

struct ProfileModel {
    
    static let shared = ProfileModel()
    
    private init() {}

    func getData() -> [CreatedRecipeModel] {
        let realm = try! Realm()
        let recipes = realm.objects(RecipeInfoRealm.self)

        // Преобразование Results<RecipeInfoRealm> в массив CreatedRecipeModel
        var createdRecipes: [CreatedRecipeModel] = []

        for recipeInfoRealm in recipes {
            let createdRecipe = CreatedRecipeModel(recipeInfoRealm: recipeInfoRealm)
            createdRecipes.append(createdRecipe)
        }
        
        return createdRecipes
    }
}
