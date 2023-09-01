//
//  ProfileModel.swift
//  BestRecipesNo8
//
//  Created by Мявкo on 1.09.23.
//

import UIKit

struct CreatedRecipeModel {
    let recipeImage: UIImage?
    let rating: Double
    let recipeName: String
    let countIngredients: Int
    let timeCooking: Int
}

struct ProfileModel {
    let profileImage: UIImage?
    
    static let savedRecipes = [
        CreatedRecipeModel(recipeImage: UIImage(named: "recipe1"), rating: 5.0, recipeName: "vegetable sauce", countIngredients: 9, timeCooking: 25),
        CreatedRecipeModel(recipeImage: UIImage(named: "recipe2"), rating: 4.8, recipeName: "sharwama", countIngredients: 5, timeCooking: 40),
        CreatedRecipeModel(recipeImage: UIImage(named: "recipe3"), rating: 4.5, recipeName: "chicken and vegetable wrap", countIngredients: 7, timeCooking: 30)
    ]
}
