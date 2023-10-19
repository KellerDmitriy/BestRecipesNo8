//
//  RouterProtocol.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 28.09.2023.
//

import UIKit

protocol BaseRouterProtocol {
    var navigationController: UINavigationController { get }
    func routeToDetailRecipeScreen(recipe: RecipeProtocol)
}

protocol MainRouterProtocol: BaseRouterProtocol {
    func routeToSeeAllScreen(recipes: [RecipeProtocol], sortOrder: Endpoint.SortOrder)
}

protocol SearchRouterProtocol: BaseRouterProtocol {}

protocol SavedRecipesRouterProtocol: BaseRouterProtocol {}

protocol ProfileRouterProtocol {
    var navigationController: UINavigationController { get }
    func routeToDetailYourRecipe(recipe: RecipeRealmModel)
}

protocol CreateRouterProtocol {
    var navigationController: UINavigationController { get }
}
