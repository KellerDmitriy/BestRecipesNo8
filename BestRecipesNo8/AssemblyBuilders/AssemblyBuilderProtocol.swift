//
//  AssemblyBuilderProtocol.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 28.09.2023.
//

import UIKit

protocol RootAssembly {
    func createTabBar() -> CustomTabBarController
    func createMainRouter() -> MainRouterProtocol
    func createSavedRecipesRouter() -> SavedRecipesRouterProtocol
    func createSearchRouter() -> SearchRouterProtocol
    func createCreateRouter() -> CreateRouterProtocol
    func createProfileRouter() -> ProfileRouterProtocol
}

protocol MainScreenAssembly {
    func createMainModule(router: MainRouterProtocol) -> MainViewController
    func createSeeAllModule(recipes: [RecipeProtocol], router: MainRouter, sortOrder: Endpoint.SortOrder) -> SeeAllViewController
    func createRecipeDetailModule(recipe: RecipeProtocol) -> RecipeDetailViewController
}

protocol SavedRecipesAssembly {
    func createSavedRecipesModule(router: SavedRecipesRouterProtocol) -> SavedRecipesViewController
    func createRecipeDetailModule(recipe: RecipeProtocol) -> RecipeDetailViewController
}

protocol SearchAssembly {
    func createSearchModule(router: SearchRouterProtocol) -> SearchViewController
    func createRecipeDetailModule(recipe: RecipeProtocol) -> RecipeDetailViewController
}

protocol ProfileAssembly {
    func createProfileModule(router: ProfileRouterProtocol) -> ProfileViewController
   // func createRecipeDetailModule(recipe: RecipeProtocol) -> RecipeDetailViewController
}

protocol CreateAssembly {
    func createCreateModule(router: CreateRouterProtocol) -> CreateViewController
}

typealias AssemblyBuilderProtocol =
RootAssembly &
MainScreenAssembly &
SavedRecipesAssembly &
CreateAssembly &
SearchAssembly &
ProfileAssembly
