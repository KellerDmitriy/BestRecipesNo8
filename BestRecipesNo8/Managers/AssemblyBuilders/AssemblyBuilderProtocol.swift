//
//  AssemblyBuilderProtocol.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 28.09.2023.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createTabBar(router: RouterProtocol) -> CustomTabBarController 
    func createMainModule(router: RouterProtocol) -> UIViewController
    func createSearchModule(router: RouterProtocol) -> UIViewController
    func createSeeAllModule(recipes: [RecipeProtocol], router: RouterProtocol, sortion: Endpoint.Sortion) -> UIViewController
    func createRecipeDetailModule(recipe: RecipeProtocol) -> UIViewController
    func createProfileModule(router: RouterProtocol) -> UIViewController
    func createSavedRecipesModule(router: RouterProtocol) -> UIViewController
    func createCreateModule(router: RouterProtocol) -> UIViewController
}
