//
//  SeeAllRouter.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 04.09.2023.
//


import UIKit

final class SeeAllRouter: SeeAllRouterProtocol {
    weak var view: UIViewController?
    
    func routeToRecipeDetailScreen(recipe: RecipeInfo) {
        let view = RecipeBuilder.createRecipeModule(recipe: recipe)
        self.view?.navigationController?.pushViewController(view, animated: true)
    }
}

