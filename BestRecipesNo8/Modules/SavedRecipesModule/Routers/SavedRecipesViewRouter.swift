//
//  SavedRecipesViewRouter.swift
//  BestRecipesNo8
//
//  Created by Мявкo on 2.09.23.
//

import UIKit

final class SavedRecipesViewRouter: SavedRecipesRouterInput {
    
    weak var view: UIViewController?
    
    func routeToRecipeDetailScreen(recipe: RecipeInfo) {
        let view = RecipeBuilder.createRecipeModule(recipe: recipe)
        self.view?.navigationController?.pushViewController(view, animated: true)
    }
}
