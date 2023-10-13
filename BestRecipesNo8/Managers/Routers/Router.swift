//
//  Router.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 28.09.2023.
//

import UIKit

class Router: RouterProtocol {
    
    
    var assemblyBuilder: AssemblyBuilderProtocol
    let navigationController: UINavigationController
    
    init(assemblyBuilder: AssemblyBuilderProtocol, navigationController: UINavigationController) {
        self.assemblyBuilder = assemblyBuilder
        self.navigationController = navigationController
    }
    
    func routeToMainScreen() {
        let mainViewController = assemblyBuilder.createMainModule(router: self)
        navigationController.pushViewController(mainViewController, animated: true)
    }
    
    func routeToSearchScreen() {
        let searchController = assemblyBuilder.createSearchModule(router: self)
        navigationController.pushViewController(searchController, animated: true)
    }
    
    func routeToSeeAllScreen(recipes: [RecipeProtocol], sortion: Endpoint.Sortion) {
        let seeAllViewController = assemblyBuilder.createSeeAllModule(recipes: recipes, router: self, sortion: sortion)
        navigationController.pushViewController(seeAllViewController, animated: true)
    }
    
    func routeToRecipeDetailScreen(recipe: RecipeProtocol) {
        let recipeDetailViewController = assemblyBuilder.createRecipeDetailModule(recipe: recipe)
        navigationController.pushViewController(recipeDetailViewController, animated: true)
    }
    
    func routeToSavedRecipesScreen() {
        let savedRecipeViewController = assemblyBuilder.createSavedRecipesModule( router: self)
        navigationController.pushViewController(savedRecipeViewController, animated: true)
    }
    
    func routeToProfileScreen() {
        let routeToProfileViewController = assemblyBuilder.createProfileModule(router: self)
        navigationController.pushViewController(routeToProfileViewController, animated: true)
    }
}
