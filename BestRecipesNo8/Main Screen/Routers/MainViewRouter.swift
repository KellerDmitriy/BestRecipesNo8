//
//  MainViewRouter.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 04.09.2023.
//

import UIKit

final class MainViewRouter: MainRouterInput {

    
    weak var view: UIViewController?
    
    func routeToSeeAllScreen(recipes: [RecipeInfo]) {
        let view = SeeAllBuilder.createSeeAllModule(recipes: recipes)
        self.view?.navigationController?.pushViewController(view, animated: true)
    }
    
    func routeToRecipeDetailScreen(recipe: RecipeInfo) {
        let view = RecipeBuilder.createRecipeModule(recipe: recipe)
        self.view?.navigationController?.pushViewController(view, animated: true)
    }
}
