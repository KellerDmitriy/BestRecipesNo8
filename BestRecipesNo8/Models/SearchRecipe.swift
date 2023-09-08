//
//  SearchRecipe.swift
//  BestRecipesNo8
//
//  Created by Aleksandr Rybachev on 28.08.2023.
//

import Foundation

struct SearchResult: Codable {
    let results: [SearchRecipe]?
}

struct SearchRecipe: Codable {
    let id: Int
    let title: String?
    let image: String?
}
