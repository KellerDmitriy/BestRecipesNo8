//
//  AssemblyBuilderProtocol.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 28.09.2023.
//

import UIKit

protocol RootAssembly {
    func createTabBar() -> CustomTabBarController
    func createHomeRouter() -> HomeRouterProtocol
    func createSavedRecipesRouter() -> SavedRecipesRouterProtocol
    func createSearchRouter() -> SearchRouterProtocol
    func createCreateRouter() -> CreateRouterProtocol
    func createProfileRouter() -> ProfileRouterProtocol
}

protocol HomeScreenAssembly {
    func createHomeModule(router: HomeRouterProtocol) -> HomeViewController
    func createSearchModule(router: SearchRouterProtocol) -> SearchViewController
    func createSeeAllModule(recipes: [RecipeProtocol], router: MainRouter, sortOrder: Endpoint.SortOrder) -> SeeAllViewController
    func createDetailModule(recipe: RecipeProtocol) -> DetailViewController
}

protocol SavedRecipesAssembly {
    func createSavedRecipesModule(router: SavedRecipesRouterProtocol) -> SavedRecipesViewController
    func createDetailModule(recipe: RecipeProtocol) -> DetailViewController
}

protocol SearchAssembly {
    func createSearchModule(router: SearchRouterProtocol) -> SearchViewController
    func createDetailModule(recipe: RecipeProtocol) -> DetailViewController
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
HomeScreenAssembly &
SavedRecipesAssembly &
CreateAssembly &
SearchAssembly &
ProfileAssembly
