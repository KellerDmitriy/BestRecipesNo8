//
//  RecipePresenter.swift
//  BestRecipesNo8
//
//  Created by Мявкo on 28.08.23.
//

import Foundation

final class RecipePresenter {
    
    weak var view: RecipeViewInput?
    private let router: RecipeRouterInput
    
    let recipe: RecipeInfo

    init(router: RecipeRouterInput, recipe: RecipeInfo) {
        self.router = router
        self.recipe = recipe
    }
    
    var getTitleRecipe: String {
        return "How to make \(recipe.title ?? "")"
    }
    
    var getRatingText: String {
        return recipe.rating
    }
    
    var getReviewsText: String {
//        return "(\(recipe.countReviews) Reviews)"
        return "(Reviews)"
    }
    
    var countIngredients: Int {
        return recipe.extendedIngredients?.count ?? 0
    }
    
    var getCountIngredientsText: String {
        return "\(countIngredients) items"
    }
    
    // height of each cell of TableView "Ingredients"
    var heightOfTableViewCell: CGFloat {
        return 76
    }
    
    func getIngredient(at index: Int) -> IngredientModel {
        guard let ingredients = recipe.extendedIngredients else { return IngredientModel(iconURL: "Empty", name: "Empty", count: "Empty") }
        let ingredient = ingredients[index]
        
        return IngredientModel(iconURL: ingredient.imageURL,
                               name: ingredient.name ?? "",
                               count: "\(ingredient.amount ?? 0)")
    }
    
    func getInstructions() -> String {
        return recipe.instuctionsLabel
    }
}
