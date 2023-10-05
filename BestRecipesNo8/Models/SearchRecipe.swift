//
//  SearchRecipe.swift
//  BestRecipesNo8
//
//  Created by Aleksandr Rybachev on 28.08.2023.
//

import Foundation

protocol RecipeProtocol {
    var id: Int { get }
    var title: String? { get }
    var image: String? { get }
    var rating: String? { get }
    var extendedIngredients: [ExtendedIngredient]? { get }
    var instuctionsLabel: String? { get }
}

struct SearchResult: Codable {
    let results: [SearchRecipe]?
}

struct SearchRecipe: Codable, RecipeProtocol {

    let id: Int
    let title: String?
    let image: String?
    var rating: String?
    var extendedIngredients: [ExtendedIngredient]?
    var instuctionsLabel: String?
}
