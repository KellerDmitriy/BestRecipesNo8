//
//  Router.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 28.09.2023.
//

import UIKit

class Router: RouterProtocol {
    
    
    var assemblyBuilder: AssemblyBuilderProtocol?
    var tabBarController: CustomTabBar?
    var navigationController: UINavigationController?
    
    init(assemblyBuilder: AssemblyBuilderProtocol, tabBarController: CustomTabBar, navigationController: UINavigationController) {
        self.assemblyBuilder = assemblyBuilder
        self.tabBarController = tabBarController
        self.navigationController = navigationController
    }
    
    func routeToInitialVC() {
//        if let tabBarController = tabBarController {
//            navigationController?.setViewControllers([tabBarController], animated: true)
//        }
        if let navigationController = navigationController {
            guard let mainViewController = assemblyBuilder?.createMainModule(router: self) else {return}
            navigationController.viewControllers = [mainViewController]
        }
    }
        func popToRoot() {
            if let navigationController = navigationController {
                navigationController.popToRootViewController(animated: true)
            }
        }
        
        func routeToMainScreen() {
            if let navigationController = navigationController {
                guard let mainViewController = assemblyBuilder?.createMainModule(router: self) else {return}
                navigationController.viewControllers = [mainViewController]
            }
        }
        
        func routeToSeeAllScreen(recipes: [RecipeInfo]) {
            if let navigationController = navigationController {
                guard let seeAllViewController = assemblyBuilder?.createSeeAllModule(recipes: recipes, router: self) else {return}
                navigationController.pushViewController(seeAllViewController, animated: true)
            }
        }
        
        func routeToRecipeDetailScreen(recipe: RecipeInfo) {
            if let navigationController = navigationController {
                guard let recipeDetailViewController = assemblyBuilder?.createRecipeDetailModule(recipe: recipe, router: self) else {return}
                navigationController.pushViewController(recipeDetailViewController, animated: true)
            }
        }
        
        func routeToSavedRecipeScreen() {
            if let navigationController = navigationController {
                guard let savedRecipeViewController = assemblyBuilder?.createSavedRecipesModule(router: self) else {return}
                navigationController.pushViewController(savedRecipeViewController, animated: true)
            }
        }
        
        func routeToProfileScreen() {
            if let navigationController = navigationController {
                guard let routeToProfileViewController = assemblyBuilder?.createProfileModule(router: self) else {return}
                navigationController.pushViewController(routeToProfileViewController, animated: true)
            }
            
        }
    }
