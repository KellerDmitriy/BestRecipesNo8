//
//  RecipeBuilder.swift
//  BestRecipesNo8
//
//  Created by Мявкo on 28.08.23.
//

import UIKit

final class RecipeBuilder {
    
    static func createRecipeModule(recipe: RecipeInfo) -> UIViewController {
        let router = RecipeViewRouter()
        let presenter = RecipePresenter(router: router, recipe: recipe)
        let view = RecipeView(presenter: presenter)
        
        presenter.view = view
        router.view = view
        
        return view
    }
}
