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

struct RecipeInfo: Codable, RecipeProtocol {
    let id: Int
    let title: String?
    let summary: String?
    let image: String?
    let sourceUrl: String?
    
    let preparationMinutes: Int?
    let cookingMinutes: Int?
    let readyInMinutes: Int?
    let servings: Int?
    
    let aggregateLikes: Int?
    let spoonacularScore: Double?
    let creditsText: String?
    let sourceName: String?
    let dichTypes: [String]?
    let diets: [String]?
    
    let extendedIngredients: [ExtendedIngredient]?
    
    let analyzedInstructions: [AnalyzedInstruction]?
    
    var rating: String? {
        guard let likes = aggregateLikes else { return "❤️ 0"}
        switch likes {
        case 1000...:
            return "❤️ \(likes / 1000)k"
        default:
            return "❤️ \(likes)"
        }
    }
    
    var instuctionsLabel: String? {
        var result: String = ""
        guard let instructions = analyzedInstructions?.first else { return "" }
        instructions.steps?.forEach {
            result.append(contentsOf: "\($0.number ?? 1). \($0.step ?? "").\n")
        }
        return result
    }
}

struct ExtendedIngredient: Codable {
    let id: Int?
    let aisle: String?
    let image: String?
    let consistency: String?
    let name: String?
    let nameClean: String?
    let amount: Double?
    let unit: String?
    let measures: Measures?
    
    var imageURL: String {
        "https://spoonacular.com/cdn/ingredients_100x100/\(image ?? "")"
    }
}

struct AnalyzedInstruction: Codable {
    let name: String?
    let steps: [Step]?
}

struct Step: Codable {
    let number: Int?
    let step: String?
}

struct Measures: Codable {
    let us: Metric?
    let metric: Metric?
}

struct Metric: Codable {
    let amount: Double?
    let unitShort: String?
    let unitLong: String?
}
