//
//  HomePresenterProtocol.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 23.10.2023.
//

import Foundation

protocol HomePresenterProtocol {
    var searchRouter: SearchRouterProtocol? { get set }
    var trendingNowRecipes: [RecipeProtocol] { get set }
    var popularCategoryRecipes: [RecipeProtocol] { get set }
    var randomRecipe: [RecipeProtocol] { get set }
    
    var managerSections: ManagerSectionsProtocol! { get }
    var networkManager: NetworkManager { get set }
    var realmStoredManager: RealmStorageManager { get set }
    var router: HomeRouterProtocol { get set }
    
   // var searchController: AssemblyBuilderProtocol { get set }
    var savedRecipes: [RecipeRealmModel] { get set }
    var savedRecipesId: [Int] { get set }
    func isRecipeSaved(recipe: RecipeProtocol) -> Bool
    func updateRecipeInSavedRecipes(recipe: RecipeProtocol)
    
    func getCreateCompletion(with recipe: RecipeProtocol) -> (() -> ())
    func addButtonTapped(for recipe: RecipeProtocol)
    
    func seeAllButtonTapped(with sortOrder: Endpoint.SortOrder)
}
