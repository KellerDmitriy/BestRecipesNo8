//
//  RecipeBuilder.swift
//  BestRecipesNo8
//
//  Created by Мявкo on 28.08.23.
//

import UIKit

final class RecipeBuilder {
    
    static func createRecipeModule(recipe: RecipeInfo) -> UIViewController {
    
        let presenter = RecipePresenter(recipe: recipe)
        let view = RecipeView(presenter: presenter)
        
        presenter.view = view
        
        return view
    }
}
