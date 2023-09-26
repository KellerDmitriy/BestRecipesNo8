//
//  SearchRouterProtocol.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 20.09.2023.
//

import Foundation

protocol SearchRouterProtocol {
    func routeToSavedRecipe()
    func routeToRecipeDetail(recipe: RecipeInfo)
}
