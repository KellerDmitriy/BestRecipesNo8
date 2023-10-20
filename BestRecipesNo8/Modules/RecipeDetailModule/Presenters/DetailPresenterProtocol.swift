//
//  RecipeViewOutput.swift
//  BestRecipesNo8
//
//  Created by Мявкo on 28.08.23.
//

import Foundation

protocol DetailPresenterProtocol: AnyObject {
    var recipe: RecipeProtocol { get }
    var getTitleRecipe: String { get }
    var getRatingText: String { get }
    var getReviewsText: String { get }
    var countIngredients: Int { get }
    var getCountIngredientsText: String { get }
    var heightOfTableViewCell: CGFloat { get }
    
    func getIngredient(at index: Int) -> IngredientModel 
    func getInstructions() -> String
    
    
}
