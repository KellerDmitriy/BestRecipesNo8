//
//  SeeAllViewRouter.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 04.09.2023.
//


import UIKit

final class SeeAllViewRouter: SeeAllRouterInput {
    weak var view: UIViewController?
    
    func routeToRecipeDetailScreen() {
        let view = RecipeBuilder.createRecipeModule()
        self.view?.navigationController?.pushViewController(view, animated: true)
    }
}

