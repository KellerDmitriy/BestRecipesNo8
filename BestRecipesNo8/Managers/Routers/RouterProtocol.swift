//
//  RouterProtocol.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 28.09.2023.
//

import UIKit

protocol MainRouterProtocol {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol { get set }
}

protocol RouterProtocol: MainRouterProtocol {
    func popToRoot<T: UIViewController>(_ viewController: T, animated: Bool)
    func routeToSearchScreen()
    func routeToSeeAllScreen(recipes: [RecipeProtocol])
    func routeToRecipeDetailScreen(recipe: RecipeProtocol)
    func routeToSavedRecipeScreen()
    func routeToProfileScreen()
}
