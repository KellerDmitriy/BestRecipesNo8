//
//  SeeAllViewOutput.swift
//  BestRecipesNo8
//
//  Created by Aleksandr Rybachev on 29.08.2023.
//

import Foundation

protocol SeeAllViewOutput {
    var trendingNowRecipes: [RecipeInfo] { get }
    func cellTapped()
    func saveButtonTapped()
}
