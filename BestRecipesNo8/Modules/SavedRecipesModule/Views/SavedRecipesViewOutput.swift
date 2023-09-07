//
//  SavedRecipesViewOutput.swift
//  BestRecipesNo8
//
//  Created by Мявкo on 2.09.23.
//

import Foundation

protocol SavedRecipesViewOutput {
    
    var savedRecipes: [RecipeInfo] { get set }
    var defaults: UserDefaults { get set }
    func removeRecipe(at index: Int)
}
