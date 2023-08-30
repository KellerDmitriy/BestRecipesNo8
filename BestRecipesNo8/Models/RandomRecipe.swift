//
//  RandomRecipe.swift
//  BestRecipesNo8
//
//  Created by Aleksandr Rybachev on 28.08.2023.
//

import Foundation

struct RandomRecipe: Codable {
    let recipes: [RecipeInfo]?
}

struct RecipeInfo: Codable {
    let id: Int?
    let title: String?
    let image: String?
    let readyInMinutes: Int?
    let spoonacularScore: Double?
    let sourceName: String?
    
    let dichTypes: [String]?
    
    let extendedIngredients: [ExtendedIngredient]?
}

struct ExtendedIngredient: Codable {
    let id: Int?
    let name: String?
    let aisle: String?
    let image: String?
}
