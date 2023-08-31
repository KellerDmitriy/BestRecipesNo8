//
//  Endpoint.swift
//  BestRecipesNo8
//
//  Created by Aleksandr Rybachev on 28.08.2023.
//

import Foundation

enum Endpoint {
    case getRecipeInfo(id: Int)
    case getRandomRecipes
    case searchRecipes
    case getPopularRecipes
    case getRecipesForMealType(type: String)
    case getRecipeInfoBulk(idRecipes: [String])
    
    var path: String {
        switch self {
        case .getRecipeInfo(id: let id):
            return "/recipes/\(id)/information"
        case .getRandomRecipes:
            return "/recipes/random"
        case .searchRecipes:
            return "/recipes/complexSearch"
        case .getPopularRecipes:
            return "/recipes/complexSearch"
        case .getRecipesForMealType(type: _):
            return "/recipes/complexSearch"
        case .getRecipeInfoBulk(idRecipes: _):
            return "/recipes/informationBulk"
        }
    }
    
}
