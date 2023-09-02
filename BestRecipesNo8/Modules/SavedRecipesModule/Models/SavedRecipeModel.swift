//
//  SavedRecipeModel.swift
//  BestRecipesNo8
//
//  Created by Мявкo on 2.09.23.
//

import UIKit

struct SavedRecipeModel {
    let recipeImage: UIImage?
    let rating: Double
    let recipeName: String
    let timeSaving: String
    
    static let savedRecipes = [
        SavedRecipeModel(recipeImage: UIImage(named: "savedRecipe1"), rating: 5.0, recipeName: "vegetable sauce", timeSaving: "15:10"),
        SavedRecipeModel(recipeImage: UIImage(named: "savedRecipe2"), rating: 4.8, recipeName: "sharwama", timeSaving: "12:45"),
        SavedRecipeModel(recipeImage: UIImage(named: "savedRecipe3"), rating: 4.5, recipeName: "chicken and vegetable wrap", timeSaving: "14:58")
    ]
}
