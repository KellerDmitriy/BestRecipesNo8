//
//  RouterProtocol.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 28.09.2023.
//

import UIKit

protocol MainRouterProtocol {
    var tabBarController: CustomTabBar? { get set }
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
}

protocol RouterProtocol: MainRouterProtocol {
    func routeToInitialVC()
    func popToRoot()
    func routeToMainScreen()
    func routeToSeeAllScreen(recipes: [RecipeInfo])
    func routeToRecipeDetailScreen(recipe: RecipeInfo)
    func routeToSavedRecipeScreen()
    func routeToProfileScreen()
}
