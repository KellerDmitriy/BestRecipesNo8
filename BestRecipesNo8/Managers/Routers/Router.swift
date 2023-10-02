//
//  Router.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 28.09.2023.
//

import UIKit

class Router: RouterProtocol {
    var assemblyBuilder: AssemblyBuilderProtocol
    var navigationController: UINavigationController?
    
    init(assemblyBuilder: AssemblyBuilderProtocol, navigationController: UINavigationController?) {
        self.assemblyBuilder = assemblyBuilder
        self.navigationController = navigationController
    }
    
    func popToRoot<T: UIViewController>(_ viewController: T, animated: Bool) {
        if let navigationController = navigationController {
            if navigationController.viewControllers.contains(viewController) {
                navigationController.setViewControllers([viewController], animated: animated)
            } else {
                print("ViewController not found in the navigation stack.")
            }
        }
    }
    
    func routeToMainScreen() {
        if let navigationController = navigationController {
            let mainViewController = assemblyBuilder.createMainModule(router: self)
            navigationController.viewControllers = [mainViewController]
        }
    }
    
    func routeToSeeAllScreen(recipes: [RecipeInfo]) {
        if let navigationController = navigationController {
            let seeAllViewController = assemblyBuilder.createSeeAllModule(recipes: recipes, router: self)
            navigationController.pushViewController(seeAllViewController, animated: true)
        }
    }
    
    func routeToRecipeDetailScreen(recipe: RecipeInfo) {
        if let navigationController = navigationController {
            let recipeDetailViewController = assemblyBuilder.createRecipeDetailModule(recipe: recipe, router: self)
            navigationController.pushViewController(recipeDetailViewController, animated: true)
        }
    }
    
    func routeToSavedRecipeScreen() {
        if let navigationController = navigationController {
            let savedRecipeViewController = assemblyBuilder.createSavedRecipesModule(router: self)
            navigationController.pushViewController(savedRecipeViewController, animated: true)
        }
    }
    
    func routeToProfileScreen() {
        if let navigationController = navigationController {
            let routeToProfileViewController = assemblyBuilder.createProfileModule(router: self)
            navigationController.pushViewController(routeToProfileViewController, animated: true)
        }
    }
}
