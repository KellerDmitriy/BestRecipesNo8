//
//  AssemblyBuilderProtocol.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 28.09.2023.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createMainModule(router: RouterProtocol, searchController: AssemblyBuilderProtocol) -> UIViewController
    func createSearchModule(router: RouterProtocol) -> UIViewController
    func createSeeAllModule(recipes: [RecipeProtocol], router: RouterProtocol) -> UIViewController
    func createRecipeDetailModule(recipe: RecipeProtocol, router: RouterProtocol) -> UIViewController
    func createProfileModule(router: RouterProtocol) -> UIViewController
    func createSavedRecipesModule(router: RouterProtocol) -> UIViewController
    func createCreateModule(router: RouterProtocol) -> UIViewController
}
