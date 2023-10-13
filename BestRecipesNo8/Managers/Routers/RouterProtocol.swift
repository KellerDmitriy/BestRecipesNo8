//
//  RouterProtocol.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 28.09.2023.
//

import UIKit

protocol MainRouterProtocol {
    var navigationController: UINavigationController { get }
    var assemblyBuilder: AssemblyBuilderProtocol { get set }
}

protocol RouterProtocol: MainRouterProtocol {
    func routeToMainScreen()
    func routeToSearchScreen()
    func routeToSeeAllScreen(recipes: [RecipeProtocol], sortion: Endpoint.Sortion)
    func routeToRecipeDetailScreen(recipe: RecipeProtocol)
    func routeToSavedRecipesScreen()
    func routeToProfileScreen()
}
