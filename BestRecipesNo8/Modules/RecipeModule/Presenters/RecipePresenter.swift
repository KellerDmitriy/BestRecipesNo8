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
    private let settingsManager: SettingsManagerProtocol
    
    let recipe: RecipeModel

    init(router: RecipeRouterInput,settingsManager: SettingsManagerProtocol) {
        
        self.router = router
        self.settingsManager = settingsManager
        recipe = RecipeModel()
    }
    
    var getTitleRecipe: String {
        return "How to make \(recipe.recipeName)"
    }
    
    var getRatingText: String {
        return recipe.rating
    }
    
    var getReviewsText: String {
        return "(\(recipe.countReviews) Reviews)"
    }
    
    var countIngredients: Int {
        return recipe.ingredients.count
    }
    
    var getCountIngredientsText: String {
        return "\(countIngredients) items"
    }
    
    // height of each cell of TableView "Ingredients"
    var heightOfTableViewCell: CGFloat {
        return 76
    }
    
    func getIngredient(at index: Int) -> IngredientModel {
        return recipe.ingredients[index]
    }
    
    func getInstructions() -> String {
        return recipe.instructions
    }
}
