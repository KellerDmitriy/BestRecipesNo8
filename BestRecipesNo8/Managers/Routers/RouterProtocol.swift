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
    func routeToMainScreen()
    func routeToSeeAllScreen(recipes: [RecipeInfo])
    func routeToRecipeDetailScreen(recipe: RecipeInfo)
    func routeToSavedRecipeScreen()
    func routeToProfileScreen()
}
